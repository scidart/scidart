import 'dart:collection';

import 'package:scidart/src/numdart/numbers/complex.dart';

/// Class to create 1 dimension ArrayComplex.
///
/// # Constructors:
/// ```dart
/// ArrayComplex(List<Complex> list) : default constructor
///
/// ArrayComplex.empty() : empty array
///
/// ArrayComplex.fromArray(Array list) : from another array
///
/// ArrayComplex.fixed(int length) : from a fixed length
/// ```
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
///
/// var list = ArrayComplex([
///   Complex(real: 3.0, imaginary: 4.0),
///   Complex(real: 3.0, imaginary: 4.0) ,
///   Complex(real: 3.0, imaginary: 4.0)]);
///
/// print(list);
///
/// /* output:
/// ArrayComplex([Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0)])
/// */
/// ```
class ArrayComplex extends ListBase<Complex> {
  List<Complex?> l = [];

  //#region constructors
  ArrayComplex(List<Complex> list) {
    l = list.toList();
  }

  ArrayComplex.empty();

  ArrayComplex.fromArray(ArrayComplex list) {
    // deep copy of the parameter
    l = list.map((element) => element).toList();
  }

  ArrayComplex.fixed(int length, {Complex? initialValue}) {
    if (initialValue != null) {
      l = List<Complex>.generate(length, (i) => initialValue);
    } else {
      l = List<Complex>.filled(length, Complex.ri(0.0, 0.0));
    }
  }

  //#endregion

  //#region operators
  @override
  set length(int newLength) {
    if (newLength < 0) {
      throw FormatException(
          'newLength must be greater equal than 0 (newLength >= 0)');
    }

    var aux = l.map((element) => element).toList();

    if (newLength == 0) {
      l = [];
    } else if (newLength > l.length) {
      l = [];
      aux.forEach((element) {
        l.add(element);
      });
      for (var i = l.length; i < newLength; i++) {
        l.add(Complex());
      }
    } else if (newLength < length) {
      l = [];
      for (var i = 0; i < newLength; i++) {
        l.add(aux[i]);
      }
    }
  }

  /// Return the length of ComplexArray
  ///
  /// # Examples
  /// ```dart
  /// var list = ArrayComplex([
  ///   Complex(real: 3.0, imaginary: 4.0),
  ///   Complex(real: 3.0, imaginary: 4.0) ,
  ///   Complex(real: 3.0, imaginary: 4.0)]);
  ///
  /// print(list.length);
  ///
  /// /* output:
  /// 3
  /// */
  /// ```
  @override
  int get length => l.length;

  @override
  Complex operator [](int index) => l[index] ?? Complex();

  @override
  void operator []=(int index, Complex value) {
    l[index] = value;
  }

  /// Multiply two arrays
  ///
  /// # Examples
  /// ```dart
  /// var list = ArrayComplex([
  ///   Complex(real: 2, imaginary: 5),
  ///   Complex(real: 2, imaginary: 5) ,
  ///   Complex(real: 2, imaginary: 5)]);
  /// var list2 = ArrayComplex([
  ///   Complex(real: 4, imaginary: -3),
  ///   Complex(real: 4, imaginary: -3),
  ///   Complex(real: 4, imaginary: -3)]);
  /// var cList = list * list2;
  ///
  /// print(clist)
  ///
  /// /* output:
  /// ArrayComplex([Complex(real: 23.0, imaginary: 14.0), Complex(real: 23.0, imaginary: 14.0), Complex(real: 23.0, imaginary: 14.0)])
  /// */
  /// ```
  ArrayComplex operator *(ArrayComplex b) {
    _checkArray(b);
    var c = ArrayComplex.fixed(length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i] * b[i];
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
  /// ``
  @override
  bool operator ==(b) {
    if (b is ArrayComplex) {
      _checkArray(b);
      for (var i = 0; i < length; i++) {
        if (this[i] != b[i]) {
          return false;
        }
      }
      return true;
    } else {
      throw ('the right object has to be an ArrayComplex type');
    }
  }

  /// Return an array given an index interval
  ///
  /// - [start] : start index close interval
  /// - [end] : end index open interval
  /// - [step] : optional, step between samples
  /// - [reverse] : optional, return a reversed array
  ///
  /// # Examples
  /// ```dart
  /// var var list = ArrayComplex([
  ///   Complex(real: 3.0, imaginary: 4.0),
  ///   Complex(real: 3.0, imaginary: 4.0),
  ///   Complex(real: 3.0, imaginary: 4.0)]);
  /// var b = list.getRangeArray(0, 1);
  ///
  /// print(b)
  ///
  /// /* output:
  /// ArrayComplex([
  ///   Complex(real: 3.0, imaginary: 4.0)
  /// ]);
  /// */
  /// ```
  ArrayComplex getRangeArray(int start, int end,
      {int step = 1, bool reverse = false}) {
    var b = ArrayComplex.empty();
    for (var i = start; i < end; i += step) {
      b.add(this[i]);
    }

    if (reverse) {
      b = ArrayComplex(b.reversed.toList());
    }

    return b;
  }
  //#endregion

  //#region overload methods
  /// Convert an ArrayComplex object to a String representation
  ///
  /// # Examples
  /// ```dart
  /// var list = ArrayComplex([
  ///   Complex(real: 3.0, imaginary: 4.0),
  ///   Complex(real: 3.0, imaginary: 4.0) ,
  ///   Complex(real: 3.0, imaginary: 4.0)]);
  ///
  /// print(list.toString());
  /// /* output
  /// ArrayComplex([Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0)])
  /// */
  /// ```
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', ']');
    return '\n  ArrayComplex($str\n  )';
  }

  //#endregion

  //#region memory operations
  /// Generate a copy of the current vector
  ArrayComplex copy() => ArrayComplex.fromArray(this);

  //#endregion

  //#region private methods
  void _checkArray(ArrayComplex b) {
    if (length != b.length) {
      throw ('both arrays need have the same dimesion');
    }
  }
//#endregion
}
