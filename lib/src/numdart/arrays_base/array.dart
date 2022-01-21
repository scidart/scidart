import 'dart:collection';

/// Class to create 1 dimension Array.
///
/// # Constructors:
/// ```dart
/// Array(List<double> list) // default constructor
///
/// Array.empty() // empty array
///
/// Array.fromArray(Array list) // from another array
///
/// Array.fixed(int length) // from a fixed length
/// ```
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
///
/// print(Array([1.0, 2.0, 3.0]));
/// print(Array.empty());
/// print(Array.fromArray(Array([1.0, 2.0, 3.0])));
/// print(Array.length(3));
///
/// /* output:
/// Array([1.0, 2.0, 3.0])
/// Array([])
/// Array([1.0, 2.0, 3.0])
/// Array([])
/// */
/// ```
class Array extends ListBase<double> {
  List<double?> l = [];

  //#region constructors
  Array(List<double> list) {
    l = list.toList();
  }

  Array.empty();

  Array.fromArray(Array list) {
    // deep copy of the parameter
    l = list.map((element) => element).toList();
  }

  Array.fixed(int length, {double? initialValue}) {
    if (initialValue != null) {
      l = List<double>.generate(length, (i) => initialValue);
    } else {
      l = List<double>.filled(length, 0.0);
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

    if (newLength == 0) {
      l.clear();
    } else if (newLength > l.length) {
      for (var i = l.length; i < newLength; i++) {
        l.add(0.0);
      }
    } else if (newLength < length) {
      l.removeRange(newLength, l.length);
    }
  }

  /// Return the length of Array
  ///
  /// # Examples
  /// ```dart
  /// var a1 = Array([1.0, 2.0, 3.0]);
  ///
  /// print(a1.length);
  ///
  /// /* output:
  /// 3
  /// */
  /// ```
  @override
  int get length => l.length;

  @override
  double operator [](int index) => l[index] as double;

  @override
  void operator []=(int index, double value) {
    l[index] = value;
  }

  /// Multiply two arrays
  ///
  /// # Examples
  /// ```dart
  /// var a1 = Array([2.0, 2.0, 2.0]);
  /// var a2 = Array([2.0, 2.0, 2.0]);
  ///
  /// print(a1 * a2);
  ///
  /// /* output:
  /// Array([4.0, 4.0, 4.0])
  /// */
  /// ```
  Array operator *(Array b) {
    _checkArray(b);
    var c = Array.fixed(length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i] * b[i];
    }
    return c;
  }

  /// Divide two arrays
  ///
  /// # Examples
  /// ```dart
  /// var a1 = Array([2.0, 2.0, 2.0]);
  /// var a2 = Array([2.0, 2.0, 2.0]);
  /// print(a1 / a2);
  ///
  /// /* output:
  /// Array([1.0, 1.0, 1.0])
  /// */
  /// ```
  Array operator /(Array b) {
    _checkArray(b);
    var c = Array.fixed(length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i] / b[i];
    }
    return c;
  }

  /// Sum two arrays
  ///
  /// # Examples
  /// ```dart
  /// var n = Array([1, 2, 3]);
  /// var n2 = Array([1, 2, 3]);
  ///
  /// print(n + n2);
  ///
  /// /* output:
  /// Array([2.0, 4.0, 6.0])
  /// */
  /// ```
  @override
  Array operator +(List<double> b) {
    _checkArray(b);
    var c = Array.fixed(length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i] + b[i];
    }
    return c;
  }

  /// Subtract two arrays
  ///
  /// # Examples
  /// ```dart
  /// var n = Array([1, 2, 3]);
  /// var n2 = Array([1, 2, 3]);
  ///
  /// print(n - n2);
  ///
  /// /* output:
  /// Array([0, 0, 0])
  /// */
  /// ```
  Array operator -(List<double> b) {
    _checkArray(b);
    var c = Array.fixed(length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i] - b[i];
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
    if (b is Array) {
      _checkArray(b);
      for (var i = 0; i < length; i++) {
        if (this[i] != b[i]) {
          return false;
        }
      }
      return true;
    } else {
      throw ('the right object has to be an Array type');
    }
  }

  /// Return an array given an index interval
  /// - [start] : start index close interval
  /// - [end] : end index open interval
  ///
  /// # Examples
  /// ```dart
  /// var a = Array([1,2,3,4,5]);
  /// var b = a.getRangeArray(1, 3);
  ///
  /// print(b);
  ///
  /// /* output:
  /// Array([2, 3]);
  /// */
  /// ```
  Array getRangeArray(int start, int end, {int step = 1}) {
    var b = Array.empty();
    for (var i = start; i < end; i += step) {
      b.add(this[i]);
    }
    return b;
  }
  //#endregion

  //#region memory operations
  /// Generate a copy of the current vector
  Array copy() => Array.fromArray(this);
  //#endregion

  //#region overload methods
  /// Convert an Array object to a String representation
  ///
  /// # Examples
  /// ```dart
  /// print(Array([1, 2, 3]));
  ///
  /// /* output:
  /// Array([1.0, 2.0, 3.0])
  /// */
  ///
  /// var str = Array([1.0, 2.0, 3.0]).toString();
  ///
  /// print(str);
  ///
  /// /* output:
  /// Array([1.0, 2.0, 3.0])
  /// */
  /// ```
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', ']');
    return '\n  Array($str)';
  }

  //#endregion

  //#region private methods
  void _checkArray(List<double> b) {
    if (length != b.length) {
      throw ('both arrays need have the same dimension');
    }
  }
  //#endregion
}
