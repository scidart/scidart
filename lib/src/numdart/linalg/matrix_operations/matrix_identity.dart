import 'package:scidart/src/numdart/arrays_base/array2d.dart';

/// Generate identity matrix
/// - [row]  Number of rows.
/// - [column]  Number of colums.
/// return An m-by-n matrix with ones on the diagonal and zeros elsewhere.
///
/// # Examples
/// ```dart
/// var i = identity(3, 3);
/// print(i);
/// /* output:
/// Array2d([
///   Array([1.0, 0.0, 0.0]),
///   Array([0.0, 1.0, 0.0]),
///   Array([0.0, 0.0, 1.0])
/// ]);
/// */
/// ```
Array2d matrixIdentity(int row, int column) {
  var X = Array2d.fixed(row, column);
  for (var i = 0; i < row; i++) {
    for (var j = 0; j < column; j++) {
      X[i][j] = (i == j ? 1.0 : 0.0);
    }
  }
  return X;
}
