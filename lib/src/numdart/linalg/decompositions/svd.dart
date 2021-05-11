import 'dart:math' as math;

import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/geometric/hypotenuse.dart';
import 'package:scidart/src/numdart/linalg/matrix_operations/matrix_sub.dart';
import 'package:scidart/src/numdart/numdart.dart';

/// Singular Value Decomposition.
/// For an m-by-n matrix A with m >= n, the singular value decomposition is
/// an m-by-n orthogonal matrix U, an n-by-n diagonal matrix S, and
/// an n-by-n orthogonal matrix V so that A = U*S*V'.
/// The singular values, sigma\[k\] = S\[k\]\[k\], are ordered so that
/// sigma\[0\] >= sigma\[1\] >= ... >= sigma\[n-1\].
/// The singular value decompostion always exists, so the constructor will
/// never fail.  The matrix condition number and the effective numerical
/// rank can be computed from this decomposition.
///
/// # References
/// 1. "Jama". https://math.nist.gov/javanumerics/jama/. Retrieved 2019-07-19.
/// 2. "Jama Github". https://github.com/fiji/Jama. Retrieved 2019-07-19.
/// 3. "Apache Commons Math Github". https://github.com/apache/commons-math. Retrieved 2019-07-19.
///
/// # Examples
/// ```dart
/// var svd = SVD(Array2d([
///   Array([4.0, 2.0, 1.0]),
///   Array([16.0, 4.0, 1.0]),
///   Array([64.0, 8.0, 1.0])
/// ]));
/// var u = svd.U();
/// var s = svd.S();
///
/// print(u);
/// print(s);
///
/// /* output:
/// Array2d([
///   Array([0.06370191, 0.63944931, -0.76618969]),
///   Array([0.24598854, 0.73399958,  0.63303575]),
///   Array([0.96717718, -0.22879947, -0.11054003])
/// ]);
///
/// Array2d([
///   Array([66.69193778, 0.0, 0.0]),
///   Array([0.0, 2.66694684, 0.0]),
///   Array([0.0, 0.0, 0.26986934]),
/// ]);
/// */
/// ```
class SVD {
  //#region Class variables
  /// Arrays for internal storage of U and V.
  /// internal storage of [_U].
  /// internal storage of [_V].
  Array2d _U = Array2d.empty(), _V = Array2d.empty();

  /// Array for internal storage of singular values.
  /// internal storage of singular values.
  Array _s = Array.empty();

  /// Row and column dimensions.
  /// - [_m] row dimension.
  /// - [_n] column dimension.
  int _m = 0, _n = 0;

  //#endregion

  //#region Constructor
  /// Construct the singular value decomposition
  /// Structure to access U, S and V.
  /// - [Arg] Rectangular matrix
  SVD(Array2d Arg) {
    // Derived from LINPACK code.
    // Initialize.
    var A = Arg.copy();
    _m = Arg.row;
    _n = Arg.column;

    /* Apparently the failing cases are only a proper subset of (m<n),
	 so let's not throw error.  Correct fix to come later?
      if (m<n) {
	  throw new IllegalArgumentException("Jama SVD only works for m >= n"); }
      */
    var nu = math.min(_m, _n).toInt();
    _s = Array.fixed(math.min(_m + 1, _n));
    _U = Array2d.fixed(_m, nu, initialValue: 0);
    _V = Array2d.fixed(_n, _n);
    var e = Array.fixed(_n);
    var work = Array.fixed(_m);
    var wantu = true;
    var wantv = true;

    // Reduce A to bidiagonal form, storing the diagonal elements
    // in s and the super-diagonal elements in e.

    var nct = math.min(_m - 1, _n);
    var nrt = math.max(0, math.min(_n - 2, _m));
    for (var k = 0; k < math.max(nct, nrt); k++) {
      if (k < nct) {
        // Compute the transformation for the k-th column and
        // place the k-th diagonal in s[k].
        // Compute 2-norm of k-th column without under/overflow.
        _s[k] = 0;
        for (var i = k; i < _m; i++) {
          _s[k] = hypotenuse(_s[k], A[i][k]);
        }
        if (_s[k] != 0.0) {
          if (A[k][k] < 0.0) {
            _s[k] = -_s[k];
          }
          for (var i = k; i < _m; i++) {
            A[i][k] /= _s[k];
          }
          A[k][k] += 1.0;
        }
        _s[k] = -_s[k];
      }
      for (var j = k + 1; j < _n; j++) {
        if ((k < nct) & (_s[k] != 0.0)) {
          // Apply the transformation.

          var t = 0.0;
          for (var i = k; i < _m; i++) {
            t += A[i][k] * A[i][j];
          }
          t = -t / A[k][k];
          for (var i = k; i < _m; i++) {
            A[i][j] += t * A[i][k];
          }
        }

        // Place the k-th row of A into e for the
        // subsequent calculation of the row transformation.

        e[j] = A[k][j];
      }
      if (wantu && (k < nct)) {
        // Place the transformation in U for subsequent back
        // multiplication.

        for (var i = k; i < _m; i++) {
          _U[i][k] = A[i][k];
        }
      }
      if (k < nrt) {
        // Compute the k-th row transformation and place the
        // k-th super-diagonal in e[k].
        // Compute 2-norm without under/overflow.
        e[k] = 0;
        for (var i = k + 1; i < _n; i++) {
          e[k] = hypotenuse(e[k], e[i]);
        }
        if (e[k] != 0.0) {
          if (e[k + 1] < 0.0) {
            e[k] = -e[k];
          }
          for (var i = k + 1; i < _n; i++) {
            e[i] /= e[k];
          }
          e[k + 1] += 1.0;
        }
        e[k] = -e[k];
        if ((k + 1 < _m) && (e[k] != 0.0)) {
          // Apply the transformation.

          for (var i = k + 1; i < _m; i++) {
            work[i] = 0.0;
          }
          for (var j = k + 1; j < _n; j++) {
            for (var i = k + 1; i < _m; i++) {
              work[i] += e[j] * A[i][j];
            }
          }
          for (var j = k + 1; j < _n; j++) {
            var t = -e[j] / e[k + 1];
            for (var i = k + 1; i < _m; i++) {
              A[i][j] += t * work[i];
            }
          }
        }
        if (wantv) {
          // Place the transformation in V for subsequent
          // back multiplication.

          for (var i = k + 1; i < _n; i++) {
            _V[i][k] = e[i];
          }
        }
      }
    }

    // Set up the final bidiagonal matrix or order p.

    var p = math.min(_n, _m + 1);
    if (nct < _n) {
      _s[nct] = A[nct][nct];
    }
    if (_m < p) {
      _s[p - 1] = 0.0;
    }
    if (nrt + 1 < p) {
      e[nrt] = A[nrt][p - 1];
    }
    e[p - 1] = 0.0;

    // If required, generate U.

    if (wantu) {
      for (var j = nct; j < nu; j++) {
        for (var i = 0; i < _m; i++) {
          _U[i][j] = 0.0;
        }
        _U[j][j] = 1.0;
      }
      for (var k = nct - 1; k >= 0; k--) {
        if (_s[k] != 0.0) {
          for (var j = k + 1; j < nu; j++) {
            var t = 0.0;
            for (var i = k; i < _m; i++) {
              t += _U[i][k] * _U[i][j];
            }
            t = -t / _U[k][k];
            for (var i = k; i < _m; i++) {
              _U[i][j] += t * _U[i][k];
            }
          }
          for (var i = k; i < _m; i++) {
            _U[i][k] = -_U[i][k];
          }
          _U[k][k] = 1.0 + _U[k][k];
          for (var i = 0; i < k - 1; i++) {
            _U[i][k] = 0.0;
          }
        } else {
          for (var i = 0; i < _m; i++) {
            _U[i][k] = 0.0;
          }
          _U[k][k] = 1.0;
        }
      }
    }

    // If required, generate V.

    if (wantv) {
      for (var k = _n - 1; k >= 0; k--) {
        if ((k < nrt) && (e[k] != 0.0)) {
          for (var j = k + 1; j < nu; j++) {
            var t = 0.0;
            for (var i = k + 1; i < _n; i++) {
              t += _V[i][k] * _V[i][j];
            }
            t = -t / _V[k + 1][k];
            for (var i = k + 1; i < _n; i++) {
              _V[i][j] += t * _V[i][k];
            }
          }
        }
        for (var i = 0; i < _n; i++) {
          _V[i][k] = 0.0;
        }
        _V[k][k] = 1.0;
      }
    }

    // Main iteration loop for the singular values.

    var pp = p - 1;
    var iter = 0;
    var eps = math.pow(2.0, -52.0).toDouble();
    var tiny = math.pow(2.0, -966.0).toDouble();
    while (p > 0) {
      int k, kase;

      // Here is where a test for too many iterations would go.

      // This section of the program inspects for
      // negligible elements in the s and e arrays.  On
      // completion the variables kase and k are set as follows.

      // kase = 1     if s(p) and e[k-1] are negligible and k<p
      // kase = 2     if s(k) is negligible and k<p
      // kase = 3     if e[k-1] is negligible, k<p, and
      //              s(k), ..., s(p) are not negligible (qr step).
      // kase = 4     if e(p-1) is negligible (convergence).
      for (k = p - 2; k >= -1; k--) {
        if (k == -1) {
          break;
        }
        if (e[k].abs() <= tiny + eps * (_s[k].abs() + _s[k + 1].abs())) {
          e[k] = 0.0;
          break;
        }
      }
      if (k == p - 2) {
        kase = 4;
      } else {
        int ks;
        for (ks = p - 1; ks >= k; ks--) {
          if (ks == k) {
            break;
          }
          var t = (ks != p ? e[ks].abs() : 0.0) +
              (ks != k + 1 ? e[ks - 1].abs() : 0.0);
          if (_s[ks].abs() <= tiny + eps * t) {
            _s[ks] = 0.0;
            break;
          }
        }
        if (ks == k) {
          kase = 3;
        } else if (ks == p - 1) {
          kase = 1;
        } else {
          kase = 2;
          k = ks;
        }
      }
      k++;

      // Perform the task indicated by kase.

      switch (kase) {
        // Deflate negligible s(p).

        case 1:
          {
            var f = e[p - 2];
            e[p - 2] = 0.0;
            for (var j = p - 2; j >= k; j--) {
              var t = hypotenuse(_s[j], f);
              var cs = _s[j] / t;
              var sn = f / t;
              _s[j] = t;
              if (j != k) {
                f = -sn * e[j - 1];
                e[j - 1] = cs * e[j - 1];
              }
              if (wantv) {
                for (var i = 0; i < _n; i++) {
                  t = cs * _V[i][j] + sn * _V[i][p - 1];
                  _V[i][p - 1] = -sn * _V[i][j] + cs * _V[i][p - 1];
                  _V[i][j] = t;
                }
              }
            }
          }
          break;

        // Split at negligible s(k).

        case 2:
          {
            var f = e[k - 1];
            e[k - 1] = 0.0;
            for (var j = k; j < p; j++) {
              var t = hypotenuse(_s[j], f);
              var cs = _s[j] / t;
              var sn = f / t;
              _s[j] = t;
              f = -sn * e[j];
              e[j] = cs * e[j];
              if (wantu) {
                for (var i = 0; i < _m; i++) {
                  t = cs * _U[i][j] + sn * _U[i][k - 1];
                  _U[i][k - 1] = -sn * _U[i][j] + cs * _U[i][k - 1];
                  _U[i][j] = t;
                }
              }
            }
          }
          break;

        // Perform one qr step.

        case 3:
          {
            // Calculate the shift.

            var scale = math.max(
                math.max(
                    math.max(math.max(_s[p - 1].abs(), _s[p - 2].abs()),
                        e[p - 2].abs()),
                    _s[k].abs()),
                e[k].abs());
            var sp = _s[p - 1] / scale;
            var spm1 = _s[p - 2] / scale;
            var epm1 = e[p - 2] / scale;
            var sk = _s[k] / scale;
            var ek = e[k] / scale;
            var b = ((spm1 + sp) * (spm1 - sp) + epm1 * epm1) / 2.0;
            var c = (sp * epm1) * (sp * epm1);
            var shift = 0.0;
            if ((b != 0.0) | (c != 0.0)) {
              shift = math.sqrt(b * b + c);
              if (b < 0.0) {
                shift = -shift;
              }
              shift = c / (b + shift);
            }
            var f = (sk + sp) * (sk - sp) + shift;
            var g = sk * ek;

            // Chase zeros.

            for (var j = k; j < p - 1; j++) {
              var t = hypotenuse(f, g);
              var cs = f / t;
              var sn = g / t;
              if (j != k) {
                e[j - 1] = t;
              }
              f = cs * _s[j] + sn * e[j];
              e[j] = cs * e[j] - sn * _s[j];
              g = sn * _s[j + 1];
              _s[j + 1] = cs * _s[j + 1];
              if (wantv) {
                for (var i = 0; i < _n; i++) {
                  t = cs * _V[i][j] + sn * _V[i][j + 1];
                  _V[i][j + 1] = -sn * _V[i][j] + cs * _V[i][j + 1];
                  _V[i][j] = t;
                }
              }
              t = hypotenuse(f, g);
              cs = f / t;
              sn = g / t;
              _s[j] = t;
              f = cs * e[j] + sn * _s[j + 1];
              _s[j + 1] = -sn * e[j] + cs * _s[j + 1];
              g = sn * e[j + 1];
              e[j + 1] = cs * e[j + 1];
              if (wantu && (j < _m - 1)) {
                for (var i = 0; i < _m; i++) {
                  t = cs * _U[i][j] + sn * _U[i][j + 1];
                  _U[i][j + 1] = -sn * _U[i][j] + cs * _U[i][j + 1];
                  _U[i][j] = t;
                }
              }
            }
            e[p - 2] = f;
            iter = iter + 1;
          }
          break;

        // Convergence.
        case 4:
          {
            // Make the singular values positive.

            if (_s[k] <= 0.0) {
              _s[k] = (_s[k] < 0.0 ? -_s[k] : 0.0);
              if (wantv) {
                for (var i = 0; i <= pp; i++) {
                  _V[i][k] = -_V[i][k];
                }
              }
            }

            // Order the singular values.

            while (k < pp) {
              if (_s[k] >= _s[k + 1]) {
                break;
              }
              var t = _s[k];
              _s[k] = _s[k + 1];
              _s[k + 1] = t;
              if (wantv && (k < _n - 1)) {
                for (var i = 0; i < _n; i++) {
                  t = _V[i][k + 1];
                  _V[i][k + 1] = _V[i][k];
                  _V[i][k] = t;
                }
              }
              if (wantu && (k < _m - 1)) {
                for (var i = 0; i < _m; i++) {
                  t = _U[i][k + 1];
                  _U[i][k + 1] = _U[i][k];
                  _U[i][k] = t;
                }
              }
              k++;
            }
            iter = 0;
            p--;
          }
          break;
      }
    }
  }

  //#endregion

  //#region Public Methods
  /// Return the left singular vectors
  /// return U
  Array2d U() {
    return matrixSub(_U, 0, _m - 1, 0, math.min(_m + 1, _n) - 1);
  }

  /// Return the right singular vectors
  /// return V
  Array2d V() {
    return matrixSub(_V, 0, _n, 0, _n);
  }

  /// Return the one-dimensional array of singular values
  /// return diagonal of S.
  Array singularValues() {
    return _s;
  }

  /// Return the diagonal matrix of singular values
  /// return S
  Array2d S() {
    var S = Array2d.fixed(_n, _n);
    for (var i = 0; i < _n; i++) {
      for (var j = 0; j < _n; j++) {
        S[i][j] = 0.0;
      }
      S[i][i] = _s[i];
    }
    return S;
  }

  /// Two norm
  /// return  max(S)
  double norm2() {
    return _s[0];
  }

  /// Two norm condition number
  /// return max(S)/min(S)
  double cond() {
    return _s[0] / _s[math.min(_m, _n) - 1];
  }

  /// Effective numerical matrix rank
  /// return Number of nonnegligible singular values.
  int rank() {
    var eps = math.pow(2.0, -52.0).toDouble();
    var tol = math.max(_m, _n) * _s[0] * eps;
    var r = 0;
    for (var i = 0; i < _s.length; i++) {
      if (_s[i] > tol) {
        r++;
      }
    }
    return r;
  }
//#endregion
}
