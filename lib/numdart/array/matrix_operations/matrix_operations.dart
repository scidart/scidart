//#region Matrix operations
import 'package:scidart/numdart/linalg/lu.dart';
import 'package:scidart/numdart/linalg/qr.dart';

import '../array.dart';
import '../array2d.dart';

///  Multiply two matrix
///  References
///  --------
///  .. [1] "Matrix multiplication using arrays". https://stackoverflow.com/questions/17623876/matrix-multiplication-using-arrays. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>     Array([4, 2, 1]),
///  >>>     Array([16, 4, 1]),
///  >>>     Array([64, 8, 1])
///  >>>  ]);
///  >>> var b = Array2d([
///  >>>    Array([1]),
///  >>>    Array([1]),
///  >>>    Array([1])
///  >>>  ]);
///  >>> matrixDot(a, b);
///  Array2d([
///    Array([7]),
///    Array([21]),
///    Array([73])
///  ]);
Array2d matrixDot(Array2d a, Array2d b) {
  a.isMatrix();
  b.isMatrix();

  int aRows = a.length;
  int aColumns = a[0].length;
  int bRows = b.length;
  int bColumns = b[0].length;

  if (aColumns != bRows) {
    throw FormatException(
        "A:Columns: ${aColumns} did not match B:Rows ${bRows}.");
  }

  var c = Array2d.fixed(aRows, bColumns, initialValue: 0.0);

  for (int i = 0; i < aRows; i++) { // aRow
    for (int j = 0; j < bColumns; j++) { // bColumn
      for (int k = 0; k < aColumns; k++) { // aColumn
        c[i][j] += (a[i][k] * b[k][j]);
      }
    }
  }

  return c;
}

///  Multiply all the columns by a Array
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>    Array([4, 2, 1]),
///  >>>    Array([16, 4, 1]),
///  >>>    Array([64, 8, 1])
///  >>> ]);
///  >>> var b = Array([2, 2, 2]);
///  >>> matrixMultiplyColumns(a, b);
///  Array2d([
///    Array([8.0, 4.0, 2.0]),
///    Array([32.0, 8.0, 2.0]),
///    Array([128.0, 16.0, 2.0])
///  ]);
Array2d matrixMultiplyColumns(Array2d a, Array b) {
  a.isMatrix();

  int aRows = a.length;
  int aColumns = a[0].length;
  int bColumns = b.length;

  if (aColumns != bColumns) {
    throw FormatException(
        "Then length of B need be the same length of columns of A");
  }

  var c = Array2d.fromArray(a); // make a copy of local

  for (int i = 0; i < aRows; i++) { //
    for (int j = 0; j < aColumns; j++) { // bColumn
      c[i][j] *= b[i];
    }
  }

  return c;
}

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

  int aRows = a.length;
  int aColumns = a[0].length;

  var c = Array.fixed(aColumns, initialValue: 0.0);

  for (int j = 0; j < aColumns; j++) { // bColumn
    for (int i = 0; i < aRows; i++) { //
      c[j] += a[i][j];
    }
  }

  return c;
}

///  Divide all the columns by a Array
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([2, 2, 2]),
///  >>>   Array([2, 2, 2]),
///  >>>   Array([2, 2, 2])
///  >>> ]);
///  >>> var b = Array([2, 2, 2]);
///  >>> matrixDivideColumns(a, b);
///  Array2d([
///    Array([1, 1, 1]),
///    Array([1, 1, 1]),
///    Array([1, 1, 1])
///  ]);
Array2d matrixDivideColumns(Array2d a, Array b) {
  a.isMatrix();

  int aRows = a.length;
  int aColumns = a[0].length;
  int bColumns = b.length;

  if (aColumns != bColumns) {
    throw FormatException(
        "Then length of B need be the same length of columns of A");
  }

  var c = Array2d.fromArray(a); // make a copy of local

  for (int i = 0; i < aRows; i++) { //
    for (int j = 0; j < aColumns; j++) { // bColumn
      c[i][j] /= b[i];
    }
  }

  return c;
}

///  generate a submatrix from a given interval
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>  Array([2, 2, 2]),
///  >>>  Array([2, 2, 2]),
///  >>>  Array([2, 2, 2])
///  >>> ]);
///  >>> matrixSub(a, 0, 1, 0, 1);
///  Array2d([
///    Array([2, 2]),
///    Array([2, 2])
///  ]);
Array2d matrixSub(Array2d a, int i0, int i1, int j0, int j1) {
  Array2d b = Array2d.fixed(i1 - i0 + 1, j1 - j0 + 1);
  try {
    for (int i = i0; i <= i1; i++) {
      for (int j = j0; j <= j1; j++) {
        b[i - i0][j - j0] = a[i][j];
      }
    }
  } catch (e) {
    throw FormatException("Submatrix indices");
  }
  return b;
}

///  Generate a QR decomposition of the matrix
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
///  >>>   Array([2.123456789, 2.123456789, 2.123456789])
///  >>> ]);
///  >>> var qr = QRDecomposition(a);
QR QRDecomposition(Array2d a) {
  a.isMatrix();
  return QR(a);
}

///  Get a submatrix where each element of [rows] array represent a column on
///  current matrix.
///  [rows]    Array of row indices.
///  [col0]   Initial column index
///  [col1]   Final column index
///  return     A(r(:),j0:j1)
///  exception  ArrayIndexOutOfBoundsException Submatrix indices
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>  Array([4.0, 2.0, 1.0]),
///  >>>  Array([16.0, 4.0, 1.0]),
///  >>>  Array([64.0, 8.0, 1.0])
///  >>> ]);
///  >>> matrixSubFromArray(a, Array([0, 1]), 0, 2);
///  Array2d([
///    Array([4.0, 2.0, 1.0]),
///    Array([16.0, 4.0, 1.0])
///  ]);
Array2d matrixSubFromArray(Array2d a, Array rows, int col0, int col1) {
  Array2d b = Array2d.fixed(rows.length, col1 - col0 + 1);
  try {
    for (int i = 0; i < rows.length; i++) {
      for (int j = col0; j <= col1; j++) {
        b[i][j - col0] = a[rows[i].toInt()][j];
      }
    }
  } catch (e) {
    throw FormatException("Submatrix indices: ${e}");
  }
  return b;
}

///  Solve A*X = B
///  [b]    right hand side
///  return     solution if A is square, least squares solution otherwise
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([3.0, 1.0]),
///  >>>   Array([1.0, 2.0])
///  >>> ]);
///  >>> var b = Array2d([
///  >>>   Array([9.0]),
///  >>>   Array([8.0])
///  >>> ]);
///  >>> matrixSolve(a, b);
///  Array2d([
///    Array([2.0]),
///    Array([3.0])
///  ]);
Array2d matrixSolve(Array2d a, Array2d b) {
  a.isMatrix();
  return (a.row == a.column ? (LU(a)).solve(b) : (QR(a)).solve(b));
}

///  Matrix inverse or pseudoinverse
///  return     inverse(A) if A is square, pseudoinverse otherwise.
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>  Array([1.0, 2.0, 3.0]),
///  >>>  Array([4.0, 5.0, 6.0]),
///  >>>  Array([7.0, 8.0, 10.0]),
///  >>> ]);
///  >>> matrixInverse(a);
///  Array2d([
///    Array([-0.666667, -1.333333, 1.0]),
///    Array([-0.666667, 3.666667, -2.0]),
///   Array([1.0, -2.0, 1.0])
///  ])
Array2d matrixInverse(Array2d a) {
  return matrixSolve(identity(a.row, a.row));
}

///  Matrix transpose.
///  return    A'
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>  Array([1.0, 2.0, 3.0]),
///  >>>  Array([4.0, 5.0, 6.0]),
///  >>>  Array([7.0, 8.0, 10.0]),
///  >>> ]);
///  >>> a.transpose();
///  Array2d([
///    Array([1.0, 4.0, 7.0]),
///    Array([2.0, 5.0, 8.0]),
///    Array([3.0, 6.0, 10.0])
///  ]);
Array2d transpose() {
  Array2d C = Array2d.fixed(row, column);
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < column; j++) {
      C[j][i] = this[i][j];
    }
  }
  return C;
}

///  Get matrix column.
///  return  Array
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([1.0, 2.0, 3.0]),
///  >>>   Array([4.0, 5.0, 6.0]),
///  >>>   Array([7.0, 8.0, 10.0]),
///  >>> ]);
///  >>> a.columnToArray(2);
///  var bExp = Array([3.0, 6.0, 10.0]);
Array columnToArray(int column) {
  var b = Array.fixed(this.row);
  for (var i = 0; i < this.row; i++) {
    b[i] = this[i][column];
  }
  return b;
}

///  One norm
///  return    maximum column sum.
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([1, 2, 3]),
///  >>>   Array([1, 2, 3]),
///  >>>   Array([1, 2, 3]),
///  >>> ]);
///  >>> a.norm1();
///  >>> 9
double norm1() {
  double f = 0;
  for (int j = 0; j < column; j++) {
    double s = 0;
    for (int i = 0; i < row; i++) {
      s += this[i][j].abs();
    }
    f = math.max(f, s);
  }
  return f;
}

///  Two norm
///  return    maximum singular value.
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([1, 2, 3]),
///  >>>   Array([1, 2, 3]),
///  >>>   Array([1, 2, 3]),
///  >>> ]);
///  >>> a.norm2();
///  6.496425037213701
double norm2() {
  return Singular(this).norm2();
}
//#endregion