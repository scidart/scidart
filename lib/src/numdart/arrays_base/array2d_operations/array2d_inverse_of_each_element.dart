import 'package:scidart/numdart.dart';

/// Compute the inverse of each elements ( x[r][l] = 1/x[r][l] )
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([2, 2, 2]),
///   Array([2, 2, 2]),
///   Array([2, 2, 2])
/// ]);
///
/// print(array2dInverseOfEachElement(a, 2););
///
/// /* output:
/// Array2d([
///   Array([0.5, 0.5, 0.5]),
///   Array([0.5, 0.5, 0.5]),
///   Array([0.5, 0.5, 0.5])
/// ])
/// */
/// ```
dynamic array2dInverseOfEachElement(Array2d a, {bool returnNewArray = false}) {
  if (returnNewArray) {
    var c = Array2d.fixed(a.row, a.column);
    a.asMap().forEach((i, row) {
      row.asMap().forEach((j, element) {
        if (element == 0) {
          c[i][j] = element;
        } else {
          c[i][j] = 1 / element;
        }
      });
    });
    return c;
  } else {
    for (var i = 0; i < a.row; i++) {
      for (var j = 0; j < a.column; j++) {
        var element = a[i][j];
        if (element == 0) {
          a[i][j] = element;
        } else {
          a[i][j] = 1 / element;
        }
      }
    }
  }
}
