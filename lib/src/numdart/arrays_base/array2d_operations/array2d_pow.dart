import 'package:scidart/numdart.dart';

/// Compute the power of each element of the array2d [a] by [exponent]
/// ( x[r][l] = x[r][l]^exponent )
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([2, 2, 2]),
///   Array([2, 2, 2]),
///   Array([2, 2, 2])
/// ]);
///
/// print(array2dPow(a, 2););
///
/// /* output:
/// Array2d([
///   Array([4.0, 4.0, 4.0]),
///   Array([4.0, 4.0, 4.0]),
///   Array([4.0, 4.0, 4.0])
/// ])
/// */
/// ```
dynamic array2dPow(Array2d a, double exponent, {bool returnNewArray = false}) {
  if (returnNewArray) {
    var c = Array2d.fixed(a.row, a.column);
    a.asMap().forEach((i, row) {
      row.asMap().forEach((j, element) {
        c[i][j] = pow(element, exponent).toDouble();
      });
    });
    return c;
  } else {
    for (var i = 0; i < a.row; i++) {
      for (var j = 0; j < a.column; j++) {
        a[i][j] = pow(a[i][j], exponent).toDouble();
      }
    }
  }
}
