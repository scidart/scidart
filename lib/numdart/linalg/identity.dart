import 'package:scidart/numdart/array/array2d.dart';

///  Generate identity matrix
///  [row]  Number of rows.
///  [column]  Number of colums.
///  return An m-by-n matrix with ones on the diagonal and zeros elsewhere.
///  Examples
///  --------
///  >>> var i  = identity(3, 3);
///  >>> i;
///  Array2d([
///    Array([1.0, 0.0, 0.0]),
///    Array([0.0, 1.0, 0.0]),
///    Array([0.0, 0.0, 1.0])
///  ]);
Array2d identity(int row, int column) {
  var X = Array2d.fixed(row, column);
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < column; j++) {
      X[i][j] = (i == j ? 1.0 : 0.0);
    }
  }
  return X;
}
