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
  //#endregion

  //#region operators
  set length(int newLength) { l.length = newLength; }

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
  void operator []=(int index, Array value) { l[index] = value; }

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
    _checkArray2dLength(b);

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
    _checkArray2dLength(b);

    for (var i = 0; i < this.length; i++) {
      if (this[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  //#endregion

  //#region array operations
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

  void _checkArray2dLength(Array2d b) {
    int aRows = this.length;
    int aColumns = this[0].length;
    int bRows = b.length;
    int bColumns = b[0].length;

    if (aRows != bRows || aColumns != bColumns) {
      throw FormatException(
          "A and B need to have the same length of rows and columns.");
    }
  }
  //#endregion
}