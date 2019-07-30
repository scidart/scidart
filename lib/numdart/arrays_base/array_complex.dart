import 'dart:collection';

import 'package:scidart/numdart/numbers/complex.dart';

///  Class to create 1 dimension ArrayComplex.
///  Constructors:
///  ----------
///  ArrayComplex(List<Complex> list) : default constructor
///
///  ArrayComplex.empty() : empty array
///
///  ArrayComplex.fromArray(Array list) : from another array
///
///  ArrayComplex.fixed(int length) : from a fixed length
///  Examples
///  --------
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> var list = ArrayComplex([
///  >>> Complex(real: 3.0, imaginary: 4.0),
///  >>> Complex(real: 3.0, imaginary: 4.0) ,
///  >>> Complex(real: 3.0, imaginary: 4.0)]);
///  >>> list
///  ArrayComplex([Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0)])
class ArrayComplex extends ListBase<Complex> {
  List<Complex> l = [];

  //#region constructors
  ArrayComplex(List<Complex> list) {
    l = list.toList();
  }

  ArrayComplex.empty();

  ArrayComplex.fromArray(ArrayComplex list) {
    // deep copy of the parameter
    l = list.map((element) => element).toList();
  }

  ArrayComplex.fixed(int length, {Complex initialValue}) {
    if (initialValue != null) {
      l = List<Complex>.generate(length, (i) => initialValue);
    } else {
      l = List<Complex>(length);
    }
  }

  //#endregion

  //#region operators
  set length(int newLength) {
    l.length = newLength;
  }

  ///  Return the length of ComplexArray
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0),
  ///  >>> Complex(real: 3.0, imaginary: 4.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 4.0)]);
  ///  >>> list.length;
  ///  3
  int get length => l.length;

  Complex operator [](int index) => l[index];

  void operator []=(int index, Complex value) {
    l[index] = value;
  }

  ///  Multiply two arrays
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 2, imaginary: 5),
  ///  >>> Complex(real: 2, imaginary: 5) ,
  ///  >>> Complex(real: 2, imaginary: 5)]);
  ///  >>> var list2 = ArrayComplex([
  ///  >>> Complex(real: 4, imaginary: -3),
  ///  >>> Complex(real: 4, imaginary: -3),
  ///  >>> Complex(real: 4, imaginary: -3)]);
  ///  >>> var cList = list * list2;
  ///  >>> clist
  ///  ArrayComplex([Complex(real: 23.0, imaginary: 14.0), Complex(real: 23.0, imaginary: 14.0), Complex(real: 23.0, imaginary: 14.0)])
  ArrayComplex operator *(ArrayComplex b) {
    _checkArray(b);
    var c = ArrayComplex.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] * b[i];
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

  //#region overload methods
  ///  Convert a ArrayComplex object to a String representation
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0),
  ///  >>> Complex(real: 3.0, imaginary: 4.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 4.0)]);
  ///  >>> list.toString();
  ///  ArrayComplex([Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0)])
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', ']');
    return '\n  ArrayComplex(${str}\n  )';
  }

  //#endregion

  //#region memory operations
  ///  Generate a copy of the current vector
  ArrayComplex copy() => ArrayComplex.fromArray(this);

  //#endregion

  //#region private methods
  void _checkArray(ArrayComplex b) {
    if (this.length != b.length) {
      throw ('both arrays need have the same dimesion');
    }
  }
//#endregion
}
