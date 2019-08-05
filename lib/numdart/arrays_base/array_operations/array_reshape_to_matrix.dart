import '../../numdart.dart';

///  Reshape a Array to a matrix with a given order
///  Examples
///  --------
///  >>> var a = Array([4.0, 4.0, 4.0, 4.0]);
///  >>> var n = arrayReshapeToMatrix(a, 2);
///  Array2d([
///    Array([4.0, 4.0]),
///    Array([4.0, 4.0])
///  ]);
Array2d arrayReshapeToMatrix(Array a, int order) {
  if (a.length % order != 0) {
    throw FormatException("order must be multiple of array length");
  }

  var b = Array2d.fixed(order, a.length ~/ order);
  for (var i = 0; i < b.row; i++) {
    for (var j = 0; j < b.column; j++) {
      b[i][j] = a[i + j];
    }
  }
  return b;
}
