import 'package:scidart/numdart.dart';

/// Add all the matrix elements for a number
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([2, 2, 2]),
///   Array([2, 2, 2]),
///   Array([2, 2, 2])
/// ]);
///
/// print(array2dAddToScalar(a, 2););
///
/// /* output:
/// Array2d([
///   Array([4.0, 4.0, 4.0]),
///   Array([4.0, 4.0, 4.0]),
///   Array([4.0, 4.0, 4.0])
/// ])
/// */
/// ```
dynamic array2dAddToScalar(Array2d a, num b, {bool returnNewArray = false}) {
  if (returnNewArray) {
    var c = Array2d.fixed(a.row, a.column);
    a.asMap().forEach((i, row) {
      row.asMap().forEach((j, element) {
        c[i][j] = element + b;
      });
    });
    return c;
  } else {
    for (var i = 0; i < a.row; i++) {
      for (var j = 0; j < a.column; j++) {
        a[i][j] = a[i][j] + b;
      }
    }
  }
}
