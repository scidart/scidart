import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/linalg/decompositions/lu.dart';
import 'package:scidart/src/numdart/linalg/decompositions/qr.dart';

/// Solve A*X = B
/// - [b] right hand side
/// return solution if A is square, least squares solution otherwise
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([3.0, 1.0]),
///   Array([1.0, 2.0])
/// ]);
/// var b = Array2d([
///   Array([9.0]),
///   Array([8.0])
/// ]);
///
/// print(matrixSolve(a, b));
///
/// /* output:
/// Array2d([
///   Array([2.0]),
///   Array([3.0])
/// ]);
/// */
/// ```
Array2d matrixSolve(Array2d a, Array2d b) {
  a.isMatrix();
  return (a.row == a.column ? (LU(a)).solve(b) : (QR(a)).solve(b));
}
