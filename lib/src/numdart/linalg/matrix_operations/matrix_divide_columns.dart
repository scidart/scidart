import '../../../numdart/numdart.dart';

/// Divide all the columns by an Array
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([2, 2, 2]),
///   Array([2, 2, 2]),
///   Array([2, 2, 2])
/// ]);
/// var b = Array([2, 2, 2]);
///
/// print(matrixDivideColumns(a, b));
///
/// /* output:
/// Array2d([
///   Array([1, 1, 1]),
///   Array([1, 1, 1]),
///   Array([1, 1, 1])
/// ]);
/// */
/// ```
Array2d matrixDivideColumns(Array2d a, Array b) {
  a.isMatrix();

  var aRows = a.length;
  var aColumns = a[0].length;
  var bColumns = b.length;

  if (aColumns != bColumns) {
    throw FormatException(
        'Then length of B need be the same length of columns of A');
  }

  var c = Array2d.fromArray(a); // make a copy of local

  for (var i = 0; i < aRows; i++) {
    //
    for (var j = 0; j < aColumns; j++) {
      // bColumn
      c[i][j] /= b[i];
    }
  }

  return c;
}
