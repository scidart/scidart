import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';

/// Multiply all the columns by an Array
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([4, 2, 1]),
///   Array([16, 4, 1]),
///   Array([64, 8, 1])
/// ]);
/// var b = Array([2, 2, 2]);
///
/// print(matrixMultiplyColumns(a, b));
///
/// /* output:
/// Array2d([
///   Array([8.0, 4.0, 2.0]),
///   Array([32.0, 8.0, 2.0]),
///   Array([128.0, 16.0, 2.0])
/// ]);
/// */
/// ```
Array2d matrixMultiplyColumns(Array2d a, Array b) {
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
      c[i][j] *= b[i];
    }
  }

  return c;
}
