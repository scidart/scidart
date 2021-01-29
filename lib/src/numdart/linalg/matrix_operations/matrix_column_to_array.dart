import '../../../numdart/numdart.dart';

/// Get matrix column.
/// return Array
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([1.0, 2.0, 3.0]),
///   Array([4.0, 5.0, 6.0]),
///   Array([7.0, 8.0, 10.0]),
/// ]);
///
/// print(matrixColumnToArray(a, 2));
///
/// /* output:
/// Array([3.0, 6.0, 10.0]);
/// */
/// ```
Array matrixColumnToArray(Array2d a, int column) {
  var b = Array.fixed(a.row);
  for (var i = 0; i < a.row; i++) {
    b[i] = a[i][column];
  }
  return b;
}
