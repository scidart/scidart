import 'package:scidart/src/numdart/arrays_base/array2d.dart';

/// Multiply two matrix
///
/// # References
/// 1. "Matrix multiplication using arrays". https://stackoverflow.com/questions/17623876/matrix-multiplication-using-arrays. Retrieved 2019-07-15.
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([4, 2, 1]),
///   Array([16, 4, 1]),
///   Array([64, 8, 1])
/// ]);
/// b = Array2d([
///   Array([1]),
///   Array([1]),
///   Array([1])
/// ]);
///
/// print(matrixDot(a, b));
///
/// /* output:
/// Array2d([
///   Array([7]),
///   Array([21]),
///   Array([73])
/// ]);
/// */
/// ```
Array2d matrixDot(Array2d a, Array2d b) {
  a.isMatrix();
  b.isMatrix();

  var aRows = a.length;
  var aColumns = a[0].length;
  var bRows = b.length;
  var bColumns = b[0].length;

  if (aColumns != bRows) {
    throw FormatException('A:Columns: $aColumns did not match B:Rows $bRows.');
  }

  var c = Array2d.fixed(aRows, bColumns, initialValue: 0.0);

  for (var i = 0; i < aRows; i++) {
    // aRow
    for (var j = 0; j < bColumns; j++) {
      // bColumn
      for (var k = 0; k < aColumns; k++) {
        // aColumn
        c[i][j] += (a[i][k] * b[k][j]);
      }
    }
  }

  return c;
}
