import 'package:scidart/src/numdart/arrays_base/array2d.dart';

/// # Matrix transpose.
/// return A'
///
/// ## Examples:
/// ```dart
/// var a = Array2d([
///   Array([1.0, 2.0, 3.0]),
///   Array([4.0, 5.0, 6.0]),
///   Array([7.0, 8.0, 10.0]),
/// ]);
///
/// matrixTranspose(a);
/// Array2d([
///   Array([1.0, 4.0, 7.0]),
///   Array([2.0, 5.0, 8.0]),
///   Array([3.0, 6.0, 10.0])
/// ]);
/// ```
Array2d matrixTranspose(Array2d a) {
  var b = Array2d.fixed(a.column, a.row);
  for (var i = 0; i < a.row; i++) {
    for (var j = 0; j < a.column; j++) {
      b[j][i] = a[i][j];
    }
  }
  return b;
}
