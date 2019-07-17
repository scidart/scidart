import 'dart:collection';
import 'dart:math' as math;

import 'package:scidart/numdart/numbers/complex.dart';

import 'arrayComplex.dart';

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
    l = list;
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
  //#endregion

  //#region array operations
  ///  Multiply all the array elements for a number
  ///  Examples
  ///  --------
  ///  >>> var list = Array([4.0, 4.0 , 4.0]);
  ///  >>> list.multiplyToScalar(2);
  ///  Array([4.0, 4.0, 4.0])
  Array multiplyToScalar(num b) {
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] * b;
    }
    return c;
  }

  ///  Divide all the array elements for a number
  ///  Examples
  ///  --------
  ///  >>> var list = Array([4.0, 8.0 , 16.0]);
  ///  >>> list.divisionToScalar(2);
  ///  Array([2.0, 4.0, 8.0])
  Array divisionToScalar(num b) {
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] / b;
    }
    return c;
  }

  ///  Convert a Array to ArrayComplex
  ///  Examples
  ///  --------
  ///  >>> var list = Array([1.0, 2.0 , 3.0]);
  ///  >>> list.toComplexArray();
  ///  ArrayComplex([Complex(real: 1.0, imaginary: 0.0), Complex(real: 2.0, imaginary: 0.0) , Complex(real: 3.0, imaginary: 0.0)])
  ArrayComplex toComplexArray() {
    var c = ArrayComplex.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = Complex(real: this[i]);
    }
    return c;
  }

  ///  Compute the cos for each element of the array
  ///  Examples
  ///  --------
  ///  >>> var n = Array([0.5*pi, pi, (3/2)*pi, 2*pi]);
  ///  >>> var cosn = n.cos();
  ///  Array([6.123233995736766e-17, -1.0, -1.8369701987210297e-16, 1.0])
  Array cos() {
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = math.cos(this[i]);
    }
    return c;
  }

  ///  Compute the square root for each element of the array
  ///  Examples
  ///  --------
  ///  >>> var n = Array([4, 4, 4]);
  ///  >>> n.sqrt();
  ///  Array([2, 2, 2])
  Array sqrt() {
    var c = Array.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = math.sqrt(this[i]);
    }
    return c;
  }

  ///  Return a Array without the last element
  ///  Examples
  ///  --------
  ///  >>> var n = Array([1, 2, 3]);
  ///  >>> n.truncateLast();
  ///  >>> n.sum(n2);
  ///  Array([1.0, 2.0])
  Array truncateLast() {
    var c = Array.fixed(this.length - 1);
    for (int i = 0; i < c.length; i++) {
      c[i] = this[i];
    }
    return c;
  }
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

  void _checkArray(Array b) {
    if (this.length != b.length) {
      throw ('both arrays need have the same dimesion');
    }
  }
  //#endregion
}
