import 'dart:collection';
import 'dart:math' as math;

import 'package:scidart/numdart/linalg/identity.dart';
import 'package:scidart/numdart/linalg/lu.dart';
import 'package:scidart/numdart/linalg/qr.dart';
import 'package:scidart/numdart/linalg/singular.dart';

import 'array.dart';

///  Class to create 2 dimensions Array.
///  Constructors:
///  ----------
///  Array2d(List<double> list) : default constructor
///
///  Array2d.empty() : empty array
///
///  Array2d.fromArray(Array list) : from another array
///
///  Array2d.fixed(int length) : from a fixed length
///  References
///  ----------
///  .. [1] "Jama". https://math.nist.gov/javanumerics/jama/. Retrieved 2019-07-17.
///  .. [2] "numpylinalg.solve". https://docs.scipy.org/doc/numpy/reference/generated/numpy.linalg.solve.html. Retrieved 2019-07-19.
///  Examples
///  --------
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> var matrix = Array2d.empty();
///  >>> var line = [1.0 ,2.0 , 3.0];
///  >>> matrix.add(line);
///  >>> matrix.add(line);
///  >>> matrix.add(line);
///  >>> matrix;
///  Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])])
class Array2d extends ListBase<Array> {
  List<Array> l = [];

  //#region constructors
  Array2d(List<Array> list) {
    _checkArray2dColunmsLength(list);
    l = list;
  }

  Array2d.empty();

  Array2d.fromArray(Array2d list) {
    // deep copy of the parameter
    l = list.map((element) => element).toList();
  }

  Array2d.fixed(int row, int column, {double initialValue}) {
    l = List<Array>(row);
    for (int i = 0; i < row; i++) {
      l[i] = Array.fixed(column, initialValue: initialValue);
    }
  }

  ///  Construct a matrix from a one-dimensional packed array
  ///  [vals] One-dimensional array of doubles, packed by columns (ala Fortran).
  ///  [mRow]    Number of rows.
  ///  [IllegalArgumentException] Array length must be a multiple of m.
  ///  Examples
  ///  --------
  ///  >>> var a =  Array2d.fromVector(Array([1, 2, 3, 4]), 2);
  ///  >>> a;
  ///  var aExpec = Array2d([
  ///    Array([1, 3]),
  ///    Array([2, 4])
  ///  ]);
  Array2d.fromVector(Array vals, int mRow) {
    var nCol = (mRow != 0 ? vals.length / mRow : 0).toInt();

    if (mRow * nCol != vals.length) {
      throw FormatException("Array length must be a multiple of mRow.");
    }

    l = List<Array>(mRow);
    for (int i = 0; i < mRow; i++) {
      l[i] = Array.fixed(nCol);
    }

    for (int i = 0; i < mRow; i++) {
      for (int j = 0; j < nCol; j++) {
        this[i][j] = vals[i + j * mRow];
      }
    }
  }
  //#endregion

  //#region properties
  int get row => l.length;

  int get column {
    _checkArray2dColunmsLength(this);
    return this[0].length;
  }

  //#endregion

  //#region operators
  set length(int newLength) {
    l.length = newLength;
  }

  ///  Return the length of Array2d
  ///  Examples
  ///  --------
  ///  >>> var matrix = Array2d.empty();
  ///  >>> var line = Array([1.0 ,2.0 , 3.0]);
  ///  >>> matrix.add(line);
  ///  >>> matrix.add(line);
  ///  >>> matrix.add(line);
  ///  >>> matrix.length;
  ///  3
  int get length => l.length;

  Array operator [](int index) => l[index];

  void operator []=(int index, Array value) {
    l[index] = value;
  }

  ///  Multiply two arrays with the same size
  ///  Examples
  ///  --------
  ///  >>> var a = Array2d([
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2])
  ///  >>> ]);
  ///  >>> var b = Array2d([
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2])
  ///  >>> ]);
  ///  >>> a * b;
  ///  Array2d([
  ///    Array([4, 4, 4]),
  ///    Array([4, 4, 4]),
  ///    Array([4, 4, 4])
  ///  ]);
  Array2d operator *(Array2d b) {
    _checkArray2dColunmsLength(this);
    _checkArray2dColunmsLength(b);
    _checkArray2dLength(this, b);

    int aRows = this.length;
    int aColumns = this[0].length;

    var c = Array2d.fromArray(this); // make a copy of local

    for (int i = 0; i < aRows; i++) { //
      for (int j = 0; j < aColumns; j++) { // bColumn
        c[i][j] *= b[i][j];
      }
    }

    return c;
  }

  ///  compare two arrays
  ///  Examples
  ///  --------
  ///  >>> var n = Array([1, 2, 3]);
  ///  >>> var n2 = Array([1, 2, 3]);
  ///  >>> n == n2;
  ///  true
  bool operator ==(b) {
    _checkArray2dColunmsLength(this);
    _checkArray2dColunmsLength(b);
    _checkArray2dLength(this, b);

    for (var i = 0; i < this.length; i++) {
      if (this[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  ///  Multiply two arrays with the same size
  ///  Examples
  ///  --------
  ///  >>> var a = Array2d([
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2])
  ///  >>> ]);
  ///  >>> var b = Array2d([
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2]),
  ///  >>>   Array([2, 2, 2])
  ///  >>> ]);
  ///  >>> a - b;
  ///  Array2d([
  ///    Array([4, 4, 4]),
  ///    Array([4, 4, 4]),
  ///    Array([4, 4, 4])
  ///  ]);
  Array2d operator -(Array2d b) {
    _checkArray2dColunmsLength(this);
    _checkArray2dColunmsLength(b);
    _checkArray2dLength(this, b);

    int aRows = this.length;
    int aColumns = this[0].length;

    var c = Array2d.fromArray(this); // make a copy of local

    for (int i = 0; i < aRows; i++) { //
      for (int j = 0; j < aColumns; j++) { // bColumn
        c[i][j] -= b[i][j];
      }
    }

    return c;
  }
  //#endregion

  //#region Matrix operations
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
  ///  >>> a.dot(b);
  ///  Array2d([
  ///    Array([7]),
  ///    Array([21]),
  ///    Array([73])
  ///  ]);
  Array2d dot(Array2d b) {
    _checkArray2dColunmsLength(this);
    _checkArray2dColunmsLength(b);

    int aRows = this.length;
    int aColumns = this[0].length;
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
          c[i][j] += (this[i][k] * b[k][j]);
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
  ///  >>> a.multiplyColumns(b);
  ///  Array2d([
  ///    Array([8.0, 4.0, 2.0]),
  ///    Array([32.0, 8.0, 2.0]),
  ///    Array([128.0, 16.0, 2.0])
  ///  ]);
  Array2d multiplyColumns(Array b) {
    _checkArray2dColunmsLength(this);

    int aRows = this.length;
    int aColumns = this[0].length;
    int bColumns = b.length;

    if (aColumns != bColumns) {
      throw FormatException(
          "Then length of B need be the same length of columns of A");
    }

    var c = Array2d.fromArray(this); // make a copy of local

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
  ///  a.sumColumns();
  ///  Array([3, 3, 3])
  Array sumColumns() {
    _checkArray2dColunmsLength(this);

    int aRows = this.length;
    int aColumns = this[0].length;

    var c = Array.fixed(aColumns, initialValue: 0.0);

    for (int j = 0; j < aColumns; j++) { // bColumn
      for (int i = 0; i < aRows; i++) { //
        c[j] += this[i][j];
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
  ///  >>> a.divideColumns(b);
  ///  Array2d([
  ///    Array([1, 1, 1]),
  ///    Array([1, 1, 1]),
  ///    Array([1, 1, 1])
  ///  ]);
  Array2d divideColumns(Array b) {
    _checkArray2dColunmsLength(this);

    int aRows = this.length;
    int aColumns = this[0].length;
    int bColumns = b.length;

    if (aColumns != bColumns) {
      throw FormatException(
          "Then length of B need be the same length of columns of A");
    }

    var c = Array2d.fromArray(this); // make a copy of local

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
  ///  >>> a.subMatrix(0, 1, 0, 1);
  ///  Array2d([
  ///    Array([2, 2]),
  ///    Array([2, 2])
  ///  ]);
  Array2d subMatrix(int i0, int i1, int j0, int j1) {
    Array2d B = Array2d.fixed(i1 - i0 + 1, j1 - j0 + 1);
    try {
      for (int i = i0; i <= i1; i++) {
        for (int j = j0; j <= j1; j++) {
          B[i - i0][j - j0] = this[i][j];
        }
      }
    } catch (e) {
      throw FormatException("Submatrix indices");
    }
    return B;
  }

  ///  Trucate all the elements of the array
  ///  Examples
  ///  --------
  ///  >>> var a = Array2d([
  ///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
  ///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
  ///  >>>   Array([2.123456789, 2.123456789, 2.123456789])
  ///  >>> ]);
  ///  >>> a.truncateEachElement(4);
  ///  Array2d([
  ///    Array([2.1235, 2.1235, 2.1235]),
  ///    Array([2.1235, 2.1235, 2.1235]),
  ///    Array([2.1235, 2.1235, 2.1235])
  ///  ]);
  void truncateEachElement(int fractionDigits) {
    for (var elem in this) {
      elem.truncateEachElement(fractionDigits);
    }
  }

  ///  Generate a QR decomposition of current array
  ///  Examples
  ///  --------
  ///  >>> var a = Array2d([
  ///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
  ///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
  ///  >>>   Array([2.123456789, 2.123456789, 2.123456789])
  ///  >>> ]);
  ///  >>> a.truncateEachElement(4);
  ///  Array2d([
  ///    Array([2.1235, 2.1235, 2.1235]),
  ///    Array([2.1235, 2.1235, 2.1235]),
  ///    Array([2.1235, 2.1235, 2.1235])
  ///  ]);
  QR QRDecomposition() {
    return QR(this);
  }

  ///  Get a submatrix where each element of [rows] array represent a column on
  ///  current array.
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
  ///  >>> a.subMatrixFromArray(Array([0, 1]), 0, 2);
  ///  Array2d([
  ///    Array([4.0, 2.0, 1.0]),
  ///    Array([16.0, 4.0, 1.0])
  ///  ]);
  Array2d subMatrixFromArray(Array rows, int col0, int col1) {
    Array2d B = Array2d.fixed(rows.length, col1 - col0 + 1);
    try {
      for (int i = 0; i < rows.length; i++) {
        for (int j = col0; j <= col1; j++) {
          B[i][j - col0] = this[rows[i].toInt()][j];
        }
      }
    } catch (e) {
      throw FormatException("Submatrix indices: ${e}");
    }
    return B;
  }

  ///  Solve A*X = B
  ///  [B]    right hand side
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
  ///  >>> a.solve(b);
  ///  Array2d([
  ///    Array([2.0]),
  ///    Array([3.0])
  ///  ]);
  Array2d solve(Array2d B) {
    return (row == column ? (LU(this)).solve(B) :
    (QR(this)).solve(B));
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
  ///  >>> a.inverse();
  ///  Array2d([
  ///    Array([-0.666667, -1.333333, 1.0]),
  ///    Array([-0.666667, 3.666667, -2.0]),
  ///   Array([1.0, -2.0, 1.0])
  ///  ])
  Array2d inverse() {
    return solve(identity(row, row));
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

  //#region overload methods
  ///  Convert a Array2d object to a String representation
  ///  Examples
  ///  --------
  ///  >>> var matrix = Array2d.empty();
  ///  >>> var line = Array([1.0 ,2.0 , 3.0]);
  ///  >>> matrix.add(line);
  ///  >>> matrix.add(line);
  ///  >>> matrix.add(line);
  ///  >>> print(matrix.toString());
  ///  Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])])
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', '\n]');
    return 'Array2d(${str})';
  }

  //#endregion

  //#region memory operations
  ///  Generate a copy of the current matrix
  Array2d copy() => Array2d.fromArray(this);

  //#endregion

  //#region private methods
  /// check all the rows have the same length of columns
  void _checkArray2dColunmsLength(List<Array> list) {
    // check if all the columns has the same length
    var columns = list[0].length;
    for (var c in list) {
      if (c.length != columns) {
        throw FormatException(
            "All the rows of the Array2d must have the same length of columns.");
      }
    }
  }

  /// check if inputs have the same size
  void _checkArray2dLength(Array2d a, Array2d b) {
    int aRows = a.length;
    int aColumns = a[0].length;
    int bRows = b.length;
    int bColumns = b[0].length;

    if (aRows != bRows || aColumns != bColumns) {
      throw FormatException(
          "A and B need to have the same length of rows and columns.");
    }
  }
//#endregion
}