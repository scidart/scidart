import 'dart:collection';

import 'array.dart';

/// Class to create 2 dimensions Array.
///
/// # Constructors:
/// ```dart
/// Array2d(List<double> list) // default constructor
///
/// Array2d.empty() // empty array
///
/// Array2d.fromArray(Array list) // from another array
///
/// Array2d.fixed(int length) // from a fixed length
/// ```
///
/// # References
/// 1. "Jama". https://math.nist.gov/javanumerics/jama/. Retrieved 2019-07-17.
/// 2. "numpylinalg.solve". https://docs.scipy.org/doc/numpy/reference/generated/numpy.linalg.solve.html. Retrieved 2019-07-19.
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
///
/// var matrix = Array2d.empty();
/// var line = [1.0 ,2.0 , 3.0];
///
/// matrix.add(line);
/// matrix.add(line);
/// matrix.add(line);
///
/// print(matrix);
///
/// /* output:
/// Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])])
/// */
/// ```
class Array2d extends ListBase<Array> {
  List<Array?> l = [];

  //#region constructors
  Array2d(List<Array> list) {
    l = list;
  }

  Array2d.empty();

  Array2d.fromArray(Array2d list) {
    // deep copy of the parameter
    l = list.map((element) => Array.fromArray(element)).toList();
  }

  Array2d.fixed(int row, int column, {double? initialValue}) {
    l = List<Array>.filled(row, Array.empty());
    for (var i = 0; i < row; i++) {
      l[i] = Array.fixed(column, initialValue: initialValue);
    }
  }

  /// Construct a matrix from a one-dimensional packed array
  /// - [vals] One-dimensional array of doubles, packed by columns (ala Fortran).
  /// - [mRow]    Number of rows.
  /// - [FormatException]: Array length must be a multiple of m.
  ///
  /// # Examples
  /// ```dart
  /// var a =  Array2d.fromVector(Array([1, 2, 3, 4]), 2);
  ///
  /// print(a);
  ///
  /// /* output:
  /// var aExpec = Array2d([
  ///   Array([1, 3]),
  ///   Array([2, 4])
  /// ]);
  /// */
  /// ```
  Array2d.fromVector(Array vals, int mRow) {
    var nCol = (mRow != 0 ? vals.length / mRow : 0).toInt();

    if (mRow * nCol != vals.length) {
      throw FormatException('Array length must be a multiple of mRow.');
    }

    l = List<Array>.filled(mRow, Array.empty());
    for (var i = 0; i < mRow; i++) {
      l[i] = Array.fixed(nCol);
    }

    for (var i = 0; i < mRow; i++) {
      for (var j = 0; j < nCol; j++) {
        this[i][j] = vals[i + j * mRow];
      }
    }
  }
  //#endregion

  //#region properties
  int get row => l.length;

  int get column {
    _checkArray2dColumnsLength(this);
    return this[0].length;
  }
  //#endregion

  //#region operators
  @override
  set length(int newLength) {
    l.length = newLength;
  }

  /// Return the length of Array2d
  ///
  /// # Examples
  /// ```dart
  /// var matrix = Array2d.empty();
  /// var line = Array([1.0 ,2.0 , 3.0]);
  /// matrix.add(line);
  /// matrix.add(line);
  /// matrix.add(line);
  ///
  /// print(matrix.length);
  ///
  /// /* output:
  /// 3
  /// */
  /// ```
  @override
  int get length => l.length;

  @override
  Array operator [](int index) => l[index] ?? Array.empty();

  @override
  void operator []=(int index, Array value) {
    l[index] = value;
  }

  /// Multiply two arrays with the same size
  ///
  /// # Examples
  /// ```dart
  /// var a = Array2d([
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2])
  /// ]);
  /// var b = Array2d([
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2])
  /// ]);
  ///
  /// print(a * b);
  ///
  /// /* output:
  /// Array2d([
  ///   Array([4, 4, 4]),
  ///   Array([4, 4, 4]),
  ///   Array([4, 4, 4])
  /// ]);
  /// */
  /// ```
  Array2d operator *(Array2d b) {
    _checkArray2dColumnsLength(this);
    _checkArray2dColumnsLength(b);
    _checkArray2dLength(this, b);

    var aRows = length;
    var aColumns = this[0].length;

    var c = Array2d.fromArray(this); // make a copy of local

    for (var i = 0; i < aRows; i++) {
      //
      for (var j = 0; j < aColumns; j++) {
        // bColumn
        c[i][j] *= b[i][j];
      }
    }

    return c;
  }

  /// Divide two arrays with the same size
  ///
  /// # Examples
  /// ```dart
  /// var a = Array2d([
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2])
  /// ]);
  /// var b = Array2d([
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2])
  /// ]);
  ///
  /// print(a / b);
  ///
  /// /* output:
  /// Array2d([
  ///   Array([1, 1, 1]),
  ///   Array([1, 1, 1]),
  ///   Array([1, 1, 1])
  /// ]);
  /// */
  /// ```
  Array2d operator /(Array2d b) {
    _checkArray2dColumnsLength(this);
    _checkArray2dColumnsLength(b);
    _checkArray2dLength(this, b);

    var aRows = length;
    var aColumns = this[0].length;

    var c = Array2d.fromArray(this); // make a copy of local

    for (var i = 0; i < aRows; i++) {
      //
      for (var j = 0; j < aColumns; j++) {
        // bColumn
        c[i][j] /= b[i][j];
      }
    }

    return c;
  }

  /// compare two arrays
  ///
  /// # Examples
  /// ```dart
  /// var n = Array([1, 2, 3]);
  /// var n2 = Array([1, 2, 3]);
  ///
  /// print(n == n2);
  ///
  /// /* output:
  /// true
  /// */
  /// ```
  @override
  bool operator ==(b) {
    if (b is Array2d) {
      _checkArray2dColumnsLength(this);
      _checkArray2dColumnsLength(b);
      _checkArray2dLength(this, b);

      for (var i = 0; i < length; i++) {
        if (this[i] != b[i]) {
          return false;
        }
      }
      return true;
    } else {
      throw ('the right object has to be an Array2d type');
    }
  }

  /// Multiply two arrays with the same size
  ///
  /// # Examples
  /// ```dart
  /// var a = Array2d([
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2])
  /// ]);
  /// var b = Array2d([
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2]),
  ///   Array([2, 2, 2])
  /// ]);
  ///
  /// print(a - b);
  ///
  /// /* output:
  /// Array2d([
  ///   Array([4, 4, 4]),
  ///   Array([4, 4, 4]),
  ///   Array([4, 4, 4])
  /// ]);
  /// */
  /// ```
  Array2d operator -(Array2d b) {
    _checkArray2dColumnsLength(this);
    _checkArray2dColumnsLength(b);
    _checkArray2dLength(this, b);

    var aRows = length;
    var aColumns = this[0].length;

    var c = Array2d.fromArray(this); // make a copy of local

    for (var i = 0; i < aRows; i++) {
      //
      for (var j = 0; j < aColumns; j++) {
        // bColumn
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
              'Array2d is not a matrix. All the rows of the Array2d must have the same length of columns.');
        } else {}
        return false;
      }
    }
    return true;
  }

  /// Return Array with the column elements
  /// - [column] column number.
  /// - [FormatException]: columns number must be in Array2d.
  ///
  /// # Examples
  /// ```dart
  /// var matrix = Array2d.empty();
  /// var line = Array([1.0, 2.0, 3.0]);
  ///
  /// matrix.add(line);
  /// matrix.add(line);
  /// matrix.add(line);
  ///
  /// print(matrix.getColumn(1));
  ///
  /// /* output:
  /// Array([2.0, 2.0, 2.0])
  /// */
  /// ```
  Array? getColumn(int column) {
    var aColumn = Array.empty();
    for (var i = 0; i < l.length; i++) {
      var row = this[i];
      if (column >= row.length) {
        throw FormatException('columns number must be in Array2d');
      }
      aColumn.add(row[column]);
    }

    return aColumn;
  }

  /// Return a Sub Array2d with the rage of rows columns elements specified
  /// - [rowStart] row start index.
  /// - [rowEnd] row end index.
  /// - [colStart] column start index.
  /// - [colEnd] column start index.
  /// - [FormatException]: rowStart and rowEnd must be in Array2d.
  ///
  /// # Examples
  /// ```dart
  /// var matrix = Array2d.empty();
  /// var line = Array([1.0, 2.0, 3.0]);
  ///
  /// matrix.add(line);
  /// matrix.add(line);
  /// matrix.add(line);
  ///
  /// print(matrix.subArray2d(0, 1, 1, 2));
  ///
  /// /* output:
  /// Array2d([
  ///   Array([2.0, 3.0]),
  ///   Array([2.0, 3.0])
  /// ])
  /// */
  /// ```
  Array2d subArray2d(int rowStart, int rowEnd, int colStart, int colEnd) {
    if (rowStart > rowEnd || rowEnd >= l.length) {
      throw FormatException('rowStart and rowEnd must be in Array2d');
    }

    var c = Array2d.empty();
    for (var i = rowStart; i <= rowEnd; i++) {
      var row = this[i];

      if (colStart > colEnd || colEnd >= row.length) {
        throw FormatException('colStart and colEnd must be in Array2d');
      }

      var rowTemp = Array.empty();
      for (var j = colStart; j <= colEnd; j++) {
        rowTemp.add(this[i][j]);
      }

      c.add(rowTemp);
    }

    return c;
  }
  //#endregion

  //#region overload methods
  /// Convert an Array2d object to a String representation
  ///
  /// # Examples
  /// ```dart
  /// var matrix = Array2d.empty();
  /// var line = Array([1.0 ,2.0 , 3.0]);
  /// matrix.add(line);
  /// matrix.add(line);
  /// matrix.add(line);
  ///
  /// print(matrix.toString());
  ///
  /// /* output:
  /// Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])])
  /// */
  /// ```
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', '\n]');
    return 'Array2d($str)';
  }

  //#endregion

  //#region memory operations
  /// Generate a copy of the current matrix
  Array2d copy() => Array2d.fromArray(this);
  //#endregion

  //#region private methods
  /// check all the rows have the same length of columns
  void _checkArray2dColumnsLength(List<Array> list) {
    // check if all the columns has the same length
    var columns = list[0].length;
    for (var c in list) {
      if (c.length != columns) {
        throw FormatException(
            'All the rows of the Array2d must have the same length of columns.');
      }
    }
  }

  /// check if inputs have the same size
  void _checkArray2dLength(Array2d a, Array2d b) {
    var aRows = a.length;
    var aColumns = a[0].length;
    var bRows = b.length;
    var bColumns = b[0].length;

    if (aRows != bRows || aColumns != bColumns) {
      throw FormatException(
          'A and B need to have the same length of rows and columns.');
    }
  }
//#endregion
}
