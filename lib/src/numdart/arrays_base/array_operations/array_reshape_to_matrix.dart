import '../../numdart.dart';

///  Reshape a Array to a matrix with a given order
///  Examples
///  --------
///  >>> var a = Array([1.0, 2.0, 3.0, 4.0]);
///  >>> arrayReshapeToMatrix(a, 2);
///  Array2d([
///    Array([1.0, 2.0]),
///    Array([3.0, 4.0])
///  ]);
Array2d arrayReshapeToMatrix(Array a, int order) {
  if (a.length % order != 0) {
    throw FormatException('order must be multiple of array length');
  }

  var b = Array2d.fixed(a.length ~/ order, order);
  var k = 0;
  for (var i = 0; i < b.row; i++) {
    for (var j = 0; j < b.column; j++) {
      b[i][j] = a[k];
      k++;
    }
  }

  return b;
}
