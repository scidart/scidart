import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/linalg/matrix_operations/matrix_identity.dart';
import 'package:scidart/src/numdart/linalg/matrix_operations/matrix_solve.dart';

import 'matrix_pseudo_inverse.dart';

/// Matrix inverse or pseudoinverse
/// return inverse(A) if A is square, pseudoinverse otherwise.
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([1.0, 2.0, 3.0]),
///   Array([4.0, 5.0, 6.0]),
///   Array([7.0, 8.0, 10.0]),
/// ]);
///
/// print(matrixInverse(a));
///
/// /* output:
/// Array2d([
///   Array([-0.666667, -1.333333, 1.0]),
///   Array([-0.666667, 3.666667, -2.0]),
///  Array([1.0, -2.0, 1.0])
/// ])
/// */
/// ```
Array2d matrixInverse(Array2d a) {
  if (a.row != a.column) {
    return matrixPseudoInverse(a);
  } else {
    return matrixSolve(a, matrixIdentity(a.row, a.row));
  }
}
