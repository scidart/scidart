import 'dart:math' as math;

import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/optimize/optimize_result.dart';

/// Algorithms of [root].
enum RootMethod {
  /// Levenberg-Marquardt: damped least squares on `|f(x)|^2`. Robust far from
  /// the root.
  lm,

  /// Newton's method with backtracking line search. Fast near the root.
  newton,

  /// Broyden's "good" method: updates an approximation of the Jacobian
  /// instead of computing it at every iteration.
  broyden1,
}

/// Find a root of the vector function [f] (from R^n to R^n) starting at
/// [x0], like `scipy.optimize.root`.
/// - [f] : function that returns an Array with the same length as its input
/// - [x0] : initial guess
/// - [method] : algorithm, [RootMethod.lm] by default
/// - [jacobian] : function that returns the Jacobian matrix `J[i][j] =
///   df_i/dx_j`. When null, it is approximated by forward differences
/// - [ftol] : the root is accepted when `max(|f(x)|) <= ftol`
/// - [xtol] : the solver stops when the step is smaller than
///   `xtol * (1 + max(|x|))`
/// - [maxIter] : maximum number of iterations
///
/// # Returns
/// - [OptimizeResult] with the solution and [OptimizeResult.success]
///
/// # References
/// 1. "scipy.optimize.root". https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.root.html. Retrieved 2026-10-13.
/// 2. J. Nocedal and S. J. Wright, "Numerical Optimization", 2nd ed., Springer, 2006, chapter 11.
/// 3. C. G. Broyden, "A class of methods for solving nonlinear simultaneous equations", Mathematics of Computation 19 (1965), 577-593.
///
/// # Examples
/// ```dart
/// // x^2 + y^2 = 4 and x = y
/// var r = root((v) => Array([v[0] * v[0] + v[1] * v[1] - 4, v[0] - v[1]]),
///     Array([1.0, 0.5]));
///
/// print(r.x);
///
/// /* output:
/// Array([1.4142135623730978, 1.4142135623730978])
/// */
/// ```
OptimizeResult root(
  Array Function(Array) f,
  Array x0, {
  RootMethod method = RootMethod.lm,
  Array2d Function(Array)? jacobian,
  double ftol = 1e-10,
  double xtol = 1e-12,
  int maxIter = 200,
}) {
  if (x0.isEmpty) {
    throw FormatException('x0 must not be empty');
  }
  if (maxIter < 1) {
    throw FormatException('maxIter must be >= 1, got $maxIter');
  }
  var solver = _Solver(f, jacobian, ftol, xtol, maxIter);
  switch (method) {
    case RootMethod.lm:
      return solver.levenbergMarquardt(x0);
    case RootMethod.newton:
      return solver.newton(x0);
    case RootMethod.broyden1:
      return solver.broyden(x0);
  }
}

class _Solver {
  final Array Function(Array) _f;
  final Array2d Function(Array)? _jacobian;
  final double ftol;
  final double xtol;
  final int maxIter;
  int calls = 0;

  _Solver(this._f, this._jacobian, this.ftol, this.xtol, this.maxIter);

  Array eval(Array x) {
    calls++;
    var fx = _f(Array(x.toList()));
    if (fx.length != x.length) {
      throw FormatException(
          'f must return ${x.length} values, returned ${fx.length}');
    }
    return fx;
  }

  Array2d jacobianAt(Array x, Array fx) {
    var analytic = _jacobian;
    if (analytic != null) return analytic(Array(x.toList()));
    // forward differences
    var n = x.length;
    var j = Array2d.fixed(n, n);
    for (var c = 0; c < n; c++) {
      var h = 1.4901161193847656e-8 * math.max(x[c].abs(), 1.0);
      var xh = Array(x.toList());
      xh[c] += h;
      h = xh[c] - x[c];
      var fh = eval(xh);
      for (var r = 0; r < n; r++) {
        j[r][c] = (fh[r] - fx[r]) / h;
      }
    }
    return j;
  }

  OptimizeResult result(Array x, Array fx, int iterations, String reason) {
    var success = _maxAbs(fx) <= ftol;
    return OptimizeResult(
      x: x,
      fun: fx,
      success: success,
      iterations: iterations,
      functionCalls: calls,
      message: success ? 'converged' : reason,
    );
  }

  bool smallStep(Array step, Array x) =>
      _maxAbs(step) <= xtol * (1 + _maxAbs(x));

  OptimizeResult newton(Array x0) {
    var x = Array(x0.toList());
    var fx = eval(x);
    for (var it = 1; it <= maxIter; it++) {
      if (_maxAbs(fx) <= ftol) return result(x, fx, it - 1, 'converged');
      var step = _solve(jacobianAt(x, fx), _scale(fx, -1));
      if (step == null) return result(x, fx, it, 'singular Jacobian');

      // backtracking line search on |f|^2
      var norm0 = _dot(fx, fx);
      var t = 1.0;
      Array xn, fn;
      while (true) {
        xn = _add(x, _scale(step, t));
        fn = eval(xn);
        if (_dot(fn, fn) < norm0 || t < 1e-4) break;
        t /= 2;
      }
      var taken = _scale(step, t);
      x = xn;
      fx = fn;
      if (smallStep(taken, x)) {
        return result(x, fx, it, 'step became smaller than xtol');
      }
    }
    return result(x, fx, maxIter, 'maximum iterations reached');
  }

  OptimizeResult broyden(Array x0) {
    var x = Array(x0.toList());
    var fx = eval(x);
    var j = jacobianAt(x, fx);
    for (var it = 1; it <= maxIter; it++) {
      if (_maxAbs(fx) <= ftol) return result(x, fx, it - 1, 'converged');
      var step = _solve(j, _scale(fx, -1));
      if (step == null) {
        // the approximation degenerated: start again from the real Jacobian
        j = jacobianAt(x, fx);
        step = _solve(j, _scale(fx, -1));
        if (step == null) return result(x, fx, it, 'singular Jacobian');
      }
      var xn = _add(x, step);
      var fn = eval(xn);
      if (!_isFinite(fn)) {
        return result(x, fx, it, 'iteration diverged');
      }
      if (smallStep(step, xn)) {
        return result(xn, fn, it, 'step became smaller than xtol');
      }

      // J += (df - J dx) dx^T / (dx . dx)
      var df = _sub(fn, fx);
      var jdx = _matVec(j, step);
      var denom = _dot(step, step);
      for (var r = 0; r < j.row; r++) {
        var u = (df[r] - jdx[r]) / denom;
        for (var c = 0; c < j.column; c++) {
          j[r][c] += u * step[c];
        }
      }
      x = xn;
      fx = fn;
    }
    return result(x, fx, maxIter, 'maximum iterations reached');
  }

  OptimizeResult levenbergMarquardt(Array x0) {
    var x = Array(x0.toList());
    var fx = eval(x);
    var cost = _dot(fx, fx);
    var lambda = 1e-3;
    for (var it = 1; it <= maxIter; it++) {
      if (_maxAbs(fx) <= ftol) return result(x, fx, it - 1, 'converged');
      var j = jacobianAt(x, fx);
      var jt = matrixTranspose(j);
      var jtj = matrixDot(jt, j);
      var g = _matVec(jt, _scale(fx, -1));

      var improved = false;
      while (lambda < 1e16) {
        var a = Array2d.fixed(jtj.row, jtj.column);
        for (var r = 0; r < jtj.row; r++) {
          for (var c = 0; c < jtj.column; c++) {
            a[r][c] = jtj[r][c];
          }
          // damping scaled by the diagonal, with a floor for zero columns
          a[r][r] += lambda * math.max(jtj[r][r], 1e-12);
        }
        var step = _solve(a, g);
        if (step != null) {
          var xn = _add(x, step);
          var fn = eval(xn);
          var costN = _dot(fn, fn);
          if (costN.isFinite && costN < cost) {
            x = xn;
            fx = fn;
            cost = costN;
            lambda = math.max(lambda / 10, 1e-12);
            improved = true;
            if (smallStep(step, x)) {
              return result(x, fx, it, 'step became smaller than xtol');
            }
            break;
          }
        }
        lambda *= 10;
      }
      if (!improved) {
        return result(x, fx, it, 'no step reduces |f(x)|');
      }
    }
    return result(x, fx, maxIter, 'maximum iterations reached');
  }
}

/// Solves a x = b, null when a is singular or the solution is not finite.
Array? _solve(Array2d a, Array b) {
  try {
    var col = Array2d.fixed(b.length, 1);
    for (var i = 0; i < b.length; i++) {
      col[i][0] = b[i];
    }
    var s = matrixSolve(a, col);
    var x = Array(List.generate(b.length, (i) => s[i][0]));
    return _isFinite(x) ? x : null;
  } catch (_) {
    return null;
  }
}

double _maxAbs(Array a) =>
    a.fold(0.0, (m, v) => v.isNaN ? double.nan : math.max(m, v.abs()));

double _dot(Array a, Array b) {
  var s = 0.0;
  for (var i = 0; i < a.length; i++) {
    s += a[i] * b[i];
  }
  return s;
}

Array _add(Array a, Array b) =>
    Array(List.generate(a.length, (i) => a[i] + b[i]));

Array _sub(Array a, Array b) =>
    Array(List.generate(a.length, (i) => a[i] - b[i]));

Array _scale(Array a, double k) => Array(a.map((v) => v * k).toList());

Array _matVec(Array2d m, Array v) =>
    Array(List.generate(m.row, (r) => _dot(m[r], v)));

bool _isFinite(Array a) => a.every((v) => v.isFinite);
