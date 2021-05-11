import 'dart:math' as math;

import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/linalg/matrix_operations/matrix_sub_from_array.dart';
import 'package:scidart/src/numdart/numdart.dart';

/// For an m-by-n matrix A with m >= n, the LU decomposition is an m-by-n
/// unit lower triangular matrix L, an n-by-n upper triangular matrix U,
/// and a permutation vector piv of length m so that A(piv,:) = L*U.
/// If m < n, then L is m-by-m and U is m-by-n.
/// The LU decomposition with pivoting always exists, even if the matrix is
/// singular, so the constructor will never fail.  The primary use of the
/// LU decomposition is in the solution of square systems of simultaneous
/// linear equations.  This will fail if isNonsingular() returns false.
///
/// # References
/// 1. "Jama". https://math.nist.gov/javanumerics/jama/. Retrieved 2019-07-17.
/// 2. "LU Decomposition in Python and NumPy". https://www.quantstart.com/articles/LU-Decomposition-in-Python-and-NumPy. Retrieved 2019-07-18.
///
/// # Examples
/// ```dart
/// var lu = LU(Array2d([
///   Array([4.0, 2.0, 1.0]),
///   Array([16.0, 4.0, 1.0]),
///    Array([64.0, 8.0, 1.0])
/// ]));
/// var l = lu.L();
/// print(l);
/// var u = lu.U();
/// print(u);
/// ```
class LU {
  //#region class variables
  /// Array for internal storage of decomposition.
  /// internal array storage.
  Array2d _LUMatrix = Array2d.empty();

  /// Row and column dimensions, and pivot sign.
  /// - [_m] column dimension.
  /// - [_n] row dimension.
  /// - [_pivsign] pivot sign.
  int _m = 0, _n = 0, _pivsign = 1;

  /// Internal storage of pivot vector.
  /// - [_piv] pivot vector.
  Array _piv = Array.empty();

  //#endregion

  //#region Constructor
  /// LU Decomposition
  /// Structure to access L, U and piv.
  /// - [A] Rectangular matrix
  LU(Array2d A) {
    // Use a "left-looking", dot-product, Crout/Doolittle algorithm.
    _LUMatrix = A.copy();
    _m = A.row;
    _n = A.column;
    _piv = Array.fixed(_m);
    for (var i = 0; i < _m; i++) {
      _piv[i] = i.toDouble();
    }
    _pivsign = 1;
    Array LUrowi;
    var LUcolj = Array.fixed(_m);

    // Outer loop.

    for (var j = 0; j < _n; j++) {
      // Make a copy of the j-th column to localize references.

      for (var i = 0; i < _m; i++) {
        LUcolj[i] = _LUMatrix[i][j];
      }

      // Apply previous transformations.

      for (var i = 0; i < _m; i++) {
        LUrowi = _LUMatrix[i];

        // Most of the time is spent in the following dot product.

        var kmax = math.min(i, j);
        var s = 0.0;
        for (var k = 0; k < kmax; k++) {
          s += LUrowi[k] * LUcolj[k];
        }

        LUrowi[j] = LUcolj[i] -= s;
      }

      // Find pivot and exchange if necessary.

      var p = j;
      for (var i = j + 1; i < _m; i++) {
        if (LUcolj[i].abs() > LUcolj[p].abs()) {
          p = i;
        }
      }
      if (p != j) {
        for (var k = 0; k < _n; k++) {
          var t = _LUMatrix[p][k];
          _LUMatrix[p][k] = _LUMatrix[j][k];
          _LUMatrix[j][k] = t;
        }
        var k = _piv[p].toInt();
        _piv[p] = _piv[j];
        _piv[j] = k.toDouble();
        _pivsign = -_pivsign;
      }

      // Compute multipliers.
      if (j < _m && _LUMatrix[j][j] != 0.0) {
        for (var i = j + 1; i < _m; i++) {
          _LUMatrix[i][j] /= _LUMatrix[j][j];
        }
      }
    }
  }

//#region Temporary, experimental code.
/*
   \** LU Decomposition, computed by Gaussian elimination.
   <P>
   This constructor computes L and U with the "daxpy"-based elimination
   algorithm used in LINPACK and MATLAB.  In Java, we suspect the dot-product,
   Crout algorithm will be faster.  We have temporarily included this
   constructor until timing experiments confirm this suspicion.
   <P>
   @param  A             Rectangular matrix
   @param  linpackflag   Use Gaussian elimination.  Actual value ignored.
   @return               Structure to access L, U and piv.
   *\

   public LUDecomposition (Matrix A, int linpackflag) {
      // Initialize.
      LU = A.getArrayCopy();
      m = A.getRowDimension();
      n = A.getColumnDimension();
      piv = new int[m];
      for (int i = 0; i < m; i++) {
         piv[i] = i;
      }
      pivsign = 1;
      // Main loop.
      for (int k = 0; k < n; k++) {
         // Find pivot.
         int p = k;
         for (int i = k+1; i < m; i++) {
            if (Math.abs(LU[i][k]) > Math.abs(LU[p][k])) {
               p = i;
            }
         }
         // Exchange if necessary.
         if (p != k) {
            for (int j = 0; j < n; j++) {
               double t = LU[p][j]; LU[p][j] = LU[k][j]; LU[k][j] = t;
            }
            int t = piv[p]; piv[p] = piv[k]; piv[k] = t;
            pivsign = -pivsign;
         }
         // Compute multipliers and eliminate k-th column.
         if (LU[k][k] != 0.0) {
            for (int i = k+1; i < m; i++) {
               LU[i][k] /= LU[k][k];
               for (int j = k+1; j < n; j++) {
                  LU[i][j] -= LU[i][k]*LU[k][j];
               }
            }
         }
      }
   }
*/
//#endregion.

//#region Public Methods
  /// Is the matrix nonsingular?
  /// return true if U, and hence A, is nonsingular.
  bool isNonsingular() {
    for (var j = 0; j < _n; j++) {
      if (_LUMatrix[j][j] == 0) {
        return false;
      }
    }
    return true;
  }

  /// Return lower triangular factor
  /// return  L
  Array2d L() {
    var L = Array2d.fixed(_m, _n);
    for (var i = 0; i < _m; i++) {
      for (var j = 0; j < _n; j++) {
        if (i > j) {
          L[i][j] = _LUMatrix[i][j];
        } else if (i == j) {
          L[i][j] = 1.0;
        } else {
          L[i][j] = 0.0;
        }
      }
    }
    return L;
  }

  /// Return upper triangular factor
  /// return U
  Array2d U() {
    var U = Array2d.fixed(_n, _n);
    for (var i = 0; i < _n; i++) {
      for (var j = 0; j < _n; j++) {
        if (i <= j) {
          U[i][j] = _LUMatrix[i][j];
        } else {
          U[i][j] = 0.0;
        }
      }
    }
    return U;
  }

  /// Return pivot permutation vector
  /// return piv
  Array pivot() {
    var p = Array.fixed(_m);
    for (var i = 0; i < _m; i++) {
      p[i] = _piv[i];
    }
    return p;
  }

  /// Return pivot permutation vector as a one-dimensional double array
  /// return (double) piv
  Array doublePivot() {
    var vals = Array.fixed(_m);
    for (var i = 0; i < _m; i++) {
      vals[i] = _piv[i];
    }
    return vals;
  }

  /// Determinant
  /// return det(A)
  /// exception FormatException Matrix must be square
  double det() {
    if (_m != _n) {
      throw FormatException('Matrix must be square.');
    }
    var d = _pivsign.toDouble();
    for (var j = 0; j < _n; j++) {
      d *= _LUMatrix[j][j];
    }
    return d;
  }

  /// Solve A*X = B
  /// - [B] A Matrix with as many rows as A and any number of columns.
  /// so that L*U*X = B(piv,:)
  /// - [FormatException] Matrix row dimensions must agree or Matrix is singular.
  Array2d solve(Array2d B) {
    if (B.row != _m) {
      throw FormatException('Matrix row dimensions must agree.');
    }
    if (!isNonsingular()) {
      throw FormatException('Matrix is singular.');
    }

    // Copy right hand side with pivoting
    var nx = B.column;
    var X = matrixSubFromArray(B, _piv, 0, nx - 1);

    // Solve L*Y = B(piv,:)
    for (var k = 0; k < _n; k++) {
      for (var i = k + 1; i < _n; i++) {
        for (var j = 0; j < nx; j++) {
          X[i][j] -= X[k][j] * _LUMatrix[i][k];
        }
      }
    }
    // Solve U*X = Y;
    for (var k = _n - 1; k >= 0; k--) {
      for (var j = 0; j < nx; j++) {
        X[k][j] /= _LUMatrix[k][k];
      }
      for (var i = 0; i < k; i++) {
        for (var j = 0; j < nx; j++) {
          X[i][j] -= X[k][j] * _LUMatrix[i][k];
        }
      }
    }
    return X;
  }
}
