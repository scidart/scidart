import 'dart:collection';

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
///  >>> import 'package:scidart/src/numdart/numdart.dart';
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
  ///  FormatException: Array length must be a multiple of m.
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

  ///  Divide two arrays with the same size
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
  ///  >>> a / b;
  ///  Array2d([
  ///    Array([1, 1, 1]),
  ///    Array([1, 1, 1]),
  ///    Array([1, 1, 1])
  ///  ]);
  Array2d operator /(Array2d b) {
    _checkArray2dColunmsLength(this);
    _checkArray2dColunmsLength(b);
    _checkArray2dLength(this, b);

    int aRows = this.length;
    int aColumns = this[0].length;

    var c = Array2d.fromArray(this); // make a copy of local

    for (int i = 0; i < aRows; i++) { //
      for (int j = 0; j < aColumns; j++) { // bColumn
        c[i][j] /= b[i][j];
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
    if (b is Array2d) {
      _checkArray2dColunmsLength(this);
      _checkArray2dColunmsLength(b);
      _checkArray2dLength(this, b);

      for (var i = 0; i < this.length; i++) {
        if (this[i] != b[i]) {
          return false;
        }
      }
      return true;
    } else {
      throw ('the right object has to be a Array2d type');
    }
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

  bool isMatrix({throwIfIsNot = true}) {
    // check if all the columns has the same length
    var columns = this[0].length;
    for (var c in this) {
      if (c.length != columns) {
        if (throwIfIsNot) {
          throw FormatException(
              "Array2d is not a matrix. All the rows of the Array2d must have the same length of columns.");
        } else {

        }
        return false;
      }
    }
    return true;
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