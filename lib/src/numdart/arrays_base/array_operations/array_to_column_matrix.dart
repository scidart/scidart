import '../../numdart.dart';

///  Convert a Array to a matrix with one column
///  Examples
///  --------
///  >>> var n = Array([4.0, 4.0, 4.0]);
///  >>> arrayToColumnMatrix(n);
///  Array2d([
///    Array([4.0]),
///    Array([4.0]),
///    Array([4.0])
///  ])
Array2d arrayToColumnMatrix(Array a) {
  var b = Array2d.fixed(a.length, 1);
  for (var i = 0; i < a.length; i++) {
    b[i][0] = a[i];
  }
  return b;
}
