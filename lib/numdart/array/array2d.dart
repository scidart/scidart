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
    l = list;
  }

  Array2d.empty();

  Array2d.fromArray(Array2d list) {
    l = list;
  }

  Array2d.fixed(int row, int column) {
    l = List<Array>(row);
    for (int i = 0; i < row; i++) {
      l[i] = Array.fixed(column);
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
}