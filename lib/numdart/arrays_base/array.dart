import 'dart:collection';

///  Class to create 1 dimension Array.
///  Constructors:
///  ----------
///  Array(List<double> list) : default constructor
///
///  Array.empty() : empty array
///
///  Array.fromArray(Array list) : from another array
///
///  Array.fixed(int length) : from a fixed length
///  Examples
///  --------
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> Array([1.0, 2.0, 3.0]);
///  Array([1.0, 2.0, 3.0])
///  >>> Array.empty();
///  Array([])
///  >>> Array.fromArray(Array([1.0, 2.0, 3.0]));
///  Array([1.0, 2.0, 3.0])
///  >>> Array.length(3);
///  Array([])
class Array extends ListBase<double> {
  List<double> l = [];

  //#region constructors
  Array(List<double> list) {
    l = list.toList();
  }

  Array.empty();

  Array.fromArray(Array list) {
    // deep copy of the parameter
    l = list.map((element) => element).toList();
  }

  Array.fixed(int length, {double initialValue}) {
    if (initialValue != null) {
      l = List<double>.generate(length, (i) => initialValue);
    } else {
      l = List<double>(length);
    }
  }
  //#endregion

  //#region operators
  set length(int newLength) {
    l.length = newLength;
  }

  ///  Return the length of Array
  ///  Examples
  ///  --------
  ///  >>> var a1 = Array([1.0, 2.0, 3.0]);
  ///  >>> a1.length;
  ///  3
  int get length => l.length;

  double operator [](int index) => l[index];

  void operator []=(int index, double value) {
    l[index] = value;
  }

  ///  Multiply two arrays
  ///  Examples
  ///  --------
  ///  >>> var a1 = Array([2.0, 2.0, 2.0]);
  ///  >>> var a2 = Array([2.0, 2.0, 2.0]);
  ///  >>> a1 * a2;
  ///  Array([4.0, 4.0, 4.0])
  Array operator *(Array b) {
    _checkArray(b);
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] * b[i];
    }
    return c;
  }

  ///  Divide two arrays
  ///  Examples
  ///  --------
  ///  >>> var a1 = Array([2.0, 2.0, 2.0]);
  ///  >>> var a2 = Array([2.0, 2.0, 2.0]);
  ///  >>> a1 / a2;
  ///  Array([1.0, 1.0, 1.0])
  Array operator /(Array b) {
    _checkArray(b);
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] / b[i];
    }
    return c;
  }

  ///  Sum two arrays
  ///  Examples
  ///  --------
  ///  >>> var n = Array([1, 2, 3]);
  ///  >>> var n2 = Array([1, 2, 3]);
  ///  >>> n + n2;
  ///  Array([2.0, 4.0, 6.0])
  @override Array operator +(List<double> b) {
    _checkArray(b);
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] + b[i];
    }
    return c;
  }

  ///  Subtract two arrays
  ///  Examples
  ///  --------
  ///  >>> var n = Array([1, 2, 3]);
  ///  >>> var n2 = Array([1, 2, 3]);
  ///  >>> n - n2;
  ///  Array([0, 0, 0])
  Array operator -(List<double> b) {
    _checkArray(b);
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] - b[i];
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
    _checkArray(b);
    for (var i = 0; i < this.length; i++) {
      if (this[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  ///  Return a array given a index interval
  ///  [start] : start index close interval
  ///  [end] : end index open interval
  ///  Examples
  ///  --------
  ///  >>> var a = Array([1,2,3,4,5]);
  ///  >>> var b = a.getRangeArray(1, 3);
  ///  >>> Array([2, 3]);
  Array getRangeArray(int start, int end, {int step = 1}) {
    var b = Array.empty();
    for (var i = start; i < end; i += step) {
      b.add(this[i]);
    }
    return b;
  }
  //#endregion

  //#region memory operations
  ///  Generate a copy of the current vector
  Array copy() => Array.fromArray(this);
  //#endregion

  //#region overload methods
  ///  Convert a Array object to a String representation
  ///  Examples
  ///  --------
  ///  >>> print(Array([1, 2, 3]));
  ///  Array([1.0, 2.0, 3.0])
  ///  >>> var str = Array([1.0, 2.0, 3.0]).toString();
  ///  >>> print(str);
  ///  Array([1.0, 2.0, 3.0])
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', ']');
    return '\n  Array(${str})';
  }

  //#endregion

  //#region private methods
  void _checkArray(Array b) {
    if (this.length != b.length) {
      throw ('both arrays need have the same dimesion');
    }
  }
  //#endregion
}
