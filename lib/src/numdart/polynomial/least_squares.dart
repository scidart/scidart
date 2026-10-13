import 'dart:math' as math;

import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/linalg/decompositions/qr.dart';
import 'package:scidart/src/numdart/linalg/decompositions/svd.dart';
import 'package:scidart/src/numdart/linalg/matrix_operations/matrix_transpose.dart';

// Internal helpers of the polynomial fits, not exported.

const double machineEpsilon = 2.220446049250313e-16;

/// Scales each column of [m] to unit norm in place and returns the scales.
/// The norm is computed relative to the largest absolute value of the
/// column, so it does not overflow or underflow for finite values.
Array normalizeColumns(Array2d m) {
  var scale = Array.fixed(m.column);
  for (var j = 0; j < m.column; j++) {
    var maxAbs = 0.0;
    for (var i = 0; i < m.row; i++) {
      maxAbs = math.max(maxAbs, m[i][j].abs());
    }
    var norm = 1.0;
    if (maxAbs > 0.0) {
      var sum = 0.0;
      for (var i = 0; i < m.row; i++) {
        var r = m[i][j] / maxAbs;
        sum += r * r;
      }
      norm = maxAbs * math.sqrt(sum);
    }
    scale[j] = norm;
    for (var i = 0; i < m.row; i++) {
      m[i][j] /= norm;
    }
  }
  return scale;
}

/// Least squares solution of a x = b. Uses QR when [a] has full column rank
/// and the minimum norm solution from the SVD otherwise, like
/// `numpy.linalg.lstsq`. Singular values below
/// `max(rows, columns) * eps * largest` count as zero.
/// Returns the solution and the rank of [a].
(Array2d, int) leastSquares(Array2d a, Array2d b) {
  var tolerance = math.max(a.row, a.column) * machineEpsilon;
  if (a.row >= a.column) {
    var qr = QR(a);
    if (qr.isFullRank(tolerance: tolerance)) {
      return (qr.solve(b), a.column);
    }
  }

  // pinv(a) = V S^-1 U^T, from the SVD of the tall one of a and a^T
  var tall = a.row >= a.column;
  var svd = SVD(tall ? a : matrixTranspose(a));
  var s = svd.singularValues();
  var u = tall ? svd.U() : svd.V();
  var v = tall ? svd.V() : svd.U();
  var cutoff = tolerance * (s.isEmpty ? 0.0 : s[0]);
  var k = math.min(a.row, a.column);

  var x = Array2d.fixed(a.column, b.column, initialValue: 0.0);
  var rank = 0;
  for (var i = 0; i < k; i++) {
    if (s[i] <= cutoff) continue;
    rank++;
    for (var c = 0; c < b.column; c++) {
      // (u_i . b_c) / s_i
      var proj = 0.0;
      for (var r = 0; r < a.row; r++) {
        proj += u[r][i] * b[r][c];
      }
      proj /= s[i];
      for (var j = 0; j < a.column; j++) {
        x[j][c] += v[j][i] * proj;
      }
    }
  }
  return (x, rank);
}

/// Whether every element of [m] is finite.
bool isFiniteMatrix(Array2d m) {
  for (var row in m) {
    for (var value in row) {
      if (!value.isFinite) return false;
    }
  }
  return true;
}
