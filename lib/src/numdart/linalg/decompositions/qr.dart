import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/geometric/hypotenuse.dart';
import 'package:scidart/src/numdart/linalg/matrix_operations/matrix_sub.dart';

/// QR Decomposition.
/// For an m-by-n matrix A with m >= n, the QR decomposition is an m-by-n
/// orthogonal matrix Q and an n-by-n upper triangular matrix R so that
/// A = Q*R.
/// The QR decompostion always exists, even if the matrix does not have
/// full rank, so the constructor will never fail.  The primary use of the
/// QR decomposition is in the least squares solution of nonsquare systems
/// of simultaneous linear equations.  This will fail if isFullRank()
/// returns false.
///
/// # References
/// 1. "QR Decomposition". https://en.wikipedia.org/wiki/QR_decomposition. Retrieved 2019-07-17.
/// 2. "Jama". https://math.nist.gov/javanumerics/jama/. Retrieved 2019-07-17.
/// 3. "QR Decomposition Algorithms". https://rosettacode.org/wiki/QR_decomposition#Java. Retrieved 2019-07-17.
/// 4. "numpy.linalg.qr". https://docs.scipy.org/doc/numpy/reference/generated/numpy.linalg.qr.html. Retrieved 2019-07-17.
///
/// # Examples
/// ```dart
/// var qr = QR(Array2d([
///    Array([4.0, 2.0, 1.0]),
///    Array([16.0, 4.0, 1.0]),
///    Array([64.0, 8.0, 1.0])
/// ]));
/// var q = qr.Q();
/// print(q);
/// var r = qr.R();
/// print(r);
/// ```
class QR {
  //#region Class variables
  ///  Array for internal storage of decomposition.
  ///  [_QR] internal array storage.
  Array2d _QR = Array2d.empty();

  ///  Row and column dimensions.
  ///  [_m] column dimension.
  ///  [_n] row dimension.
  int _m = 0, _n = 0;

  ///  Array for internal storage of diagonal of R.
  ///  [_Rdiag] diagonal of R.
  Array _Rdiag = Array.empty();

  //#endregion

  //#region Constructor
  ///  QR Decomposition, computed by Householder reflections.
  ///  Structure to access R and the Householder vectors and compute Q.
  ///  [A] Rectangular matrix
  QR(Array2d A) {
    // Initialize.
    _QR = A.copy();
    _m = A.row;
    _n = A.column;
    _Rdiag = Array.fixed(_n);

    // Main loop.
    for (var k = 0; k < _n; k++) {
      // Compute 2-norm of k-th column without under/overflow.
      var nrm = 0.0;
      for (var i = k; i < _m; i++) {
        nrm = hypotenuse(nrm, _QR[i][k]);
      }

      if (nrm != 0.0) {
        // bug fixed to correct the signal of last column
        // Form k-th Householder vector.
//        if (_QR[k][k] < 0) {
//          nrm = -nrm;
//        }
        for (var i = k; i < _m; i++) {
          _QR[i][k] /= nrm;
        }
        _QR[k][k] += 1.0;

        // Apply transformation to remaining columns.
        for (var j = k + 1; j < _n; j++) {
          var s = 0.0;
          for (var i = k; i < _m; i++) {
            s += _QR[i][k] * _QR[i][j];
          }
          s = -s / _QR[k][k];
          for (var i = k; i < _m; i++) {
            _QR[i][j] += s * _QR[i][k];
          }
        }
      }
      _Rdiag[k] = -nrm;
    }
  }

  //#endregion

  //#region Public Methods
  ///  Is the matrix full rank?
  ///  return true if R, and hence A, has full rank.
  bool isFullRank() {
    for (var j = 0; j < _n; j++) {
      if (_Rdiag[j] == 0) {
        return false;
      }
    }
    return true;
  }

  ///  Return the Householder vectors
  ///  return Lower trapezoidal matrix whose columns define the reflections
  Array2d H() {
    var H = Array2d.fixed(_m, _n);
    for (var i = 0; i < _m; i++) {
      for (var j = 0; j < _n; j++) {
        if (i >= j) {
          H[i][j] = _QR[i][j];
        } else {
          H[i][j] = 0.0;
        }
      }
    }
    return H;
  }

  ///  Return the upper triangular factor R
  Array2d R() {
    var R = Array2d.fixed(_n, _n);
    for (var i = 0; i < _n; i++) {
      for (var j = 0; j < _n; j++) {
        if (i < j) {
          R[i][j] = _QR[i][j];
        } else if (i == j) {
          R[i][j] = _Rdiag[i];
        } else {
          R[i][j] = 0.0;
        }
      }
    }
    return R;
  }

  ///  Generate and return the (economy-sized) orthogonal factor Q
  Array2d Q() {
    var Q = Array2d.fixed(_m, _n);
    for (var k = _n - 1; k >= 0; k--) {
      for (var i = 0; i < _m; i++) {
        Q[i][k] = 0.0;
      }
      Q[k][k] = 1.0;
      for (var j = k; j < _n; j++) {
        if (_QR[k][k] != 0) {
          var s = 0.0;
          for (var i = k; i < _m; i++) {
            s += _QR[i][k] * Q[i][j];
          }
          s = -s / _QR[k][k];
          for (var i = k; i < _m; i++) {
            Q[i][j] += s * _QR[i][k];
          }
        }
      }
    }
    return Q;
  }

  ///  Least squares solution of A*X = B
  ///  [B]    A Matrix with as many rows as A and any number of columns.
  ///  return X that minimizes the two norm of Q*R*X-B.
  Array2d solve(Array2d B) {
    if (B.row != _m) {
      throw FormatException('Matrix row dimensions must agree.');
    }
    if (!isFullRank()) {
      throw FormatException('Matrix is rank deficient.');
    }

    // Copy right hand side
    var nx = B.column;
    var X = B.copy();

    // Compute Y = transpose(Q)*B
    for (var k = 0; k < _n; k++) {
      for (var j = 0; j < nx; j++) {
        var s = 0.0;
        for (var i = k; i < _m; i++) {
          s += _QR[i][k] * X[i][j];
        }
        s = -s / _QR[k][k];
        for (var i = k; i < _m; i++) {
          X[i][j] += s * _QR[i][k];
        }
      }
    }
    // Solve R*X = Y;
    for (var k = _n - 1; k >= 0; k--) {
      for (var j = 0; j < nx; j++) {
        X[k][j] /= _Rdiag[k];
      }
      for (var i = 0; i < k; i++) {
        for (var j = 0; j < nx; j++) {
          X[i][j] -= X[k][j] * _QR[i][k];
        }
      }
    }
    return (matrixSub(X, 0, _n - 1, 0, nx - 1));
  }
//#endregion
}
