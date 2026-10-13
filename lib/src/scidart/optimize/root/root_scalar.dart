import 'dart:math' as math;

import 'package:scidart/src/scidart/optimize/optimize_result.dart';

/// Algorithms of [rootScalar].
enum RootScalarMethod {
  /// Bisection. Needs a bracket. Slow but always converges.
  bisect,

  /// Brent's method (inverse quadratic interpolation with bisection
  /// fallback). Needs a bracket. Fast and always converges.
  brentq,

  /// Newton-Raphson. Needs `x0` and the derivative `fprime`.
  newton,

  /// Secant method. Needs `x0` (and optionally `x1`).
  secant,
}

/// Find a root of the scalar function [f], like `scipy.optimize.root_scalar`.
/// - [f] : function of one variable
/// - [method] : algorithm. The default is [RootScalarMethod.brentq] when
///   [bracket] is given, [RootScalarMethod.newton] when [fprime] is given and
///   [RootScalarMethod.secant] otherwise
/// - [bracket] : interval `[a, b]` with `f(a)` and `f(b)` of opposite signs,
///   for bisect and brentq
/// - [x0], [x1] : initial guesses, for newton and secant
/// - [fprime] : derivative of [f], for newton
/// - [xtol], [rtol] : the root is accepted when the step is smaller than
///   `xtol + rtol * |root|`
/// - [maxIter] : maximum number of iterations
///
/// # Returns
/// - [RootScalarResult] with the root and [RootScalarResult.converged]
///
/// # References
/// 1. "scipy.optimize.root_scalar". https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.root_scalar.html. Retrieved 2026-10-13.
/// 2. R. P. Brent, "Algorithms for Minimization Without Derivatives", Prentice-Hall, 1973, chapter 4.
/// 3. "brentq.c". https://github.com/scipy/scipy/blob/main/scipy/optimize/Zeros/brentq.c. Retrieved 2026-10-13.
///
/// # Examples
/// ```dart
/// var r = rootScalar((x) => x * x - 2, bracket: [0.0, 2.0]);
///
/// print(r.root);
///
/// /* output:
/// 1.4142135623731364
/// */
/// ```
RootScalarResult rootScalar(
  double Function(double) f, {
  RootScalarMethod? method,
  List<double>? bracket,
  double? x0,
  double? x1,
  double Function(double)? fprime,
  double xtol = 2e-12,
  double rtol = 8.881784197001252e-16,
  int maxIter = 100,
}) {
  method ??= bracket != null
      ? RootScalarMethod.brentq
      : fprime != null
          ? RootScalarMethod.newton
          : RootScalarMethod.secant;

  if (xtol <= 0 || rtol < 0) {
    throw FormatException('xtol must be > 0 and rtol >= 0');
  }
  if (maxIter < 1) {
    throw FormatException('maxIter must be >= 1, got $maxIter');
  }

  switch (method) {
    case RootScalarMethod.bisect:
    case RootScalarMethod.brentq:
      if (bracket == null || bracket.length != 2) {
        throw FormatException('$method needs a bracket [a, b]');
      }
      return method == RootScalarMethod.bisect
          ? _bisect(f, bracket[0], bracket[1], xtol, rtol, maxIter)
          : _brentq(f, bracket[0], bracket[1], xtol, rtol, maxIter);
    case RootScalarMethod.newton:
      if (x0 == null || fprime == null) {
        throw FormatException('newton needs x0 and fprime');
      }
      return _newton(f, fprime, x0, xtol, rtol, maxIter);
    case RootScalarMethod.secant:
      if (x0 == null) {
        throw FormatException('secant needs x0');
      }
      return _secant(f, x0, x1, xtol, rtol, maxIter);
  }
}

RootScalarResult _result(
    double root, bool converged, int iterations, int calls, String message) {
  return RootScalarResult(
    root: root,
    converged: converged,
    iterations: iterations,
    functionCalls: calls,
    message: message,
  );
}

void _checkBracket(double fa, double fb) {
  if (fa.isNaN || fb.isNaN) {
    throw FormatException('f is NaN at the bracket');
  }
  // compare signs, not the product: tiny values underflow to zero
  if (fa.sign * fb.sign > 0) {
    throw FormatException('f(a) and f(b) must have different signs');
  }
}

RootScalarResult _bisect(double Function(double) f, double a, double b,
    double xtol, double rtol, int maxIter) {
  var fa = f(a);
  var fb = f(b);
  var calls = 2;
  _checkBracket(fa, fb);
  if (fa == 0) return _result(a, true, 0, calls, 'converged');
  if (fb == 0) return _result(b, true, 0, calls, 'converged');

  var dm = b - a;
  var xm = a;
  for (var i = 1; i <= maxIter; i++) {
    dm /= 2;
    xm = a + dm;
    var fm = f(xm);
    calls++;
    if (fm.sign * fa.sign >= 0) {
      a = xm;
    }
    if (fm == 0 || dm.abs() < xtol + rtol * xm.abs()) {
      return _result(xm, true, i, calls, 'converged');
    }
  }
  return _result(xm, false, maxIter, calls, 'maximum iterations reached');
}

RootScalarResult _brentq(double Function(double) f, double a, double b,
    double xtol, double rtol, int maxIter) {
  var xpre = a, xcur = b;
  var fpre = f(a), fcur = f(b);
  var calls = 2;
  _checkBracket(fpre, fcur);
  if (fpre == 0) return _result(xpre, true, 0, calls, 'converged');
  if (fcur == 0) return _result(xcur, true, 0, calls, 'converged');

  var xblk = 0.0, fblk = 0.0, spre = 0.0, scur = 0.0;
  for (var i = 1; i <= maxIter; i++) {
    if (fpre != 0 && fcur != 0 && fpre.sign != fcur.sign) {
      xblk = xpre;
      fblk = fpre;
      spre = scur = xcur - xpre;
    }
    if (fblk.abs() < fcur.abs()) {
      xpre = xcur;
      xcur = xblk;
      xblk = xpre;
      fpre = fcur;
      fcur = fblk;
      fblk = fpre;
    }

    var delta = (xtol + rtol * xcur.abs()) / 2;
    var sbis = (xblk - xcur) / 2;
    if (fcur == 0 || sbis.abs() < delta) {
      return _result(xcur, true, i, calls, 'converged');
    }

    if (spre.abs() > delta && fcur.abs() < fpre.abs()) {
      double stry;
      if (xpre == xblk) {
        // interpolate
        stry = -fcur * (xcur - xpre) / (fcur - fpre);
      } else {
        // extrapolate
        var dpre = (fpre - fcur) / (xpre - xcur);
        var dblk = (fblk - fcur) / (xblk - xcur);
        stry =
            -fcur * (fblk * dblk - fpre * dpre) / (dblk * dpre * (fblk - fpre));
      }
      if (2 * stry.abs() < math.min(spre.abs(), 3 * sbis.abs() - delta)) {
        // good short step
        spre = scur;
        scur = stry;
      } else {
        // bisect
        spre = sbis;
        scur = sbis;
      }
    } else {
      // bisect
      spre = sbis;
      scur = sbis;
    }

    xpre = xcur;
    fpre = fcur;
    if (scur.abs() > delta) {
      xcur += scur;
    } else {
      xcur += sbis > 0 ? delta : -delta;
    }
    fcur = f(xcur);
    calls++;
  }
  return _result(xcur, false, maxIter, calls, 'maximum iterations reached');
}

RootScalarResult _newton(
    double Function(double) f,
    double Function(double) fprime,
    double x0,
    double xtol,
    double rtol,
    int maxIter) {
  var x = x0;
  var calls = 0;
  for (var i = 1; i <= maxIter; i++) {
    var fx = f(x);
    calls++;
    if (fx == 0) return _result(x, true, i, calls, 'converged');
    var dfx = fprime(x);
    calls++;
    if (dfx == 0) {
      return _result(x, false, i, calls, 'derivative was zero');
    }
    var next = x - fx / dfx;
    if (!next.isFinite) {
      return _result(x, false, i, calls, 'iteration diverged');
    }
    if ((next - x).abs() < xtol + rtol * next.abs()) {
      return _result(next, true, i, calls, 'converged');
    }
    x = next;
  }
  return _result(x, false, maxIter, calls, 'maximum iterations reached');
}

RootScalarResult _secant(double Function(double) f, double x0, double? x1,
    double xtol, double rtol, int maxIter) {
  // same default second point as scipy
  var p0 = x0;
  var p1 = x1 ?? x0 * (1 + 1e-4) + (x0 >= 0 ? 1e-4 : -1e-4);
  var q0 = f(p0);
  var q1 = f(p1);
  var calls = 2;
  if (q1.abs() < q0.abs()) {
    var t = p0;
    p0 = p1;
    p1 = t;
    var tq = q0;
    q0 = q1;
    q1 = tq;
  }
  for (var i = 1; i <= maxIter; i++) {
    if (q1 == 0) return _result(p1, true, i, calls, 'converged');
    if (q1 == q0) {
      return _result(p1, false, i, calls, 'secant was horizontal');
    }
    var p = p1 - q1 * (p1 - p0) / (q1 - q0);
    if (!p.isFinite) {
      return _result(p1, false, i, calls, 'iteration diverged');
    }
    if ((p - p1).abs() < xtol + rtol * p.abs()) {
      return _result(p, true, i, calls, 'converged');
    }
    p0 = p1;
    q0 = q1;
    p1 = p;
    q1 = f(p1);
    calls++;
  }
  return _result(p1, false, maxIter, calls, 'maximum iterations reached');
}
