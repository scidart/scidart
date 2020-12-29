import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';

///  Sum the all columns of the array
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>    Array([1, 1, 1]),
///  >>>    Array([1, 1, 1]),
///  >>>    Array([1, 1, 1])
///  >>> ]);
///  >>> matrixSumColumns(a);
///  Array([3, 3, 3])
Array matrixSumColumns(Array2d a) {
  a.isMatrix();

  var aRows = a.length;
  var aColumns = a[0].length;

  var c = Array.fixed(aColumns, initialValue: 0.0);

  for (var j = 0; j < aColumns; j++) {
    // bColumn
    for (var i = 0; i < aRows; i++) {
      //
      c[j] += a[i][j];
    }
  }

  return c;
}
