import 'dart:collection';

import 'package:scidart/numdart/arrays_base/array.dart';
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

  //#region array operations
  ///  Multiply all the array elements for a number
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 2.0, imaginary: 2.0),
  ///  >>> Complex(real: 2.0, imaginary: 2.0) ,
  ///  >>> Complex(real: 2.0, imaginary: 2.0)]);
  ///  >>> list.multiplyToScalar(2);
  ///  ArrayComplex([Complex(real: 4.0, imaginary: 4.0), Complex(real: 4.0, imaginary: 4.0), Complex(real: 4.0, imaginary: 4.0)])
  ArrayComplex multiplyToScalar(num b) {
    var c = ArrayComplex.fixed(this.length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i].multiplyScalar(b);
    }

    return c;
  }

  ///  Divide all the array elements for a number
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 4.0, imaginary: 4.0),
  ///  >>> Complex(real: 8.0, imaginary: 8.0) ,
  ///  >>> Complex(real: 16.0, imaginary: 16.0)]);
  ///  >>> list.divisionToScalar(2);
  ///  ArrayComplex([Complex(real: 2.0, imaginary: 2.0), Complex(real: 4.0, imaginary: 4.0), Complex(real: 8.0, imaginary: 8.0)])
  ArrayComplex divisionToScalar(num b) {
    var c = ArrayComplex.fixed(this.length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i].divideScalar(b);
    }

    return c;
  }

  ///  Sum two arrays
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 1, imaginary: 1),
  ///  >>> Complex(real: 1, imaginary: 1) ,
  ///  >>> Complex(real: 1, imaginary: 1)]);
  ///  >>> var list2 = ArrayComplex([
  ///  >>> Complex(real: 1, imaginary: 1),
  ///  >>> Complex(real: 1, imaginary: 1),
  ///  >>> Complex(real: 1, imaginary: 1)]);
  ///  >>> list.sum(list2);
  ///  ArrayComplex([Complex(real: 2.0, imaginary: 2.0), Complex(real: 2.0, imaginary: 2.0), Complex(real: 2.0, imaginary: 2.0)])
  ArrayComplex sum(ArrayComplex b) {
    var c = ArrayComplex.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i] + b[i];
    }
    return c;
  }

  ///  Compute the cos for each element of the array
  ///  Examples
  ///  --------
  ///  >>>  var c1 = Complex(real: 3.0, imaginary: 4.0);
  ///  >>>  c1.cos();
  ///  Complex(real: -27.034945603074224, imaginary: -3.8511533348117775)
  ArrayComplex cos() {
    var c = ArrayComplex.fixed(this.length);
    for (int i = 0; i < this.length; i++) {
      c[i] = this[i].cos();
    }
    return c;
  }

  ///  Conjugate of all elements of the current array
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 1.0, imaginary: 1.0),
  ///  >>> Complex(real: 2.0, imaginary: 2.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 3.0) ]);
  ///  >>> list.conjugate();
  ///  ArrayComplex([Complex(real: 1.0, imaginary: -1.0), Complex(real: 2.0, imaginary: -2.0), Complex(real: 3.0, imaginary: -3.0)])
  ArrayComplex conjugate() {
    var c = ArrayComplex.fixed(this.length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i].conjugate();
    }
    return c;
  }

  ///  Absolute value of all elements of the current array
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0),
  ///  >>> Complex(real: 3.0, imaginary: 4.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 4.0)]);
  ///  >>> list.abs();
  ///  Array([5.0, 5.0, 5.0])
  Array abs() {
    var c = Array.fixed(this.length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i].abs();
    }
    return c;
  }

  ///  Return a Array without the last element
  ///  Examples
  ///  --------
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0),
  ///  >>> Complex(real: 3.0, imaginary: 4.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 4.0)]);
  ///  >>> list.cos()
  ///  ArrayComplex([Complex(real: -27.034945603074224, imaginary: -3.8511533348117775), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775)])
  ArrayComplex truncateLast() {
    var c = ArrayComplex.fixed(this.length - 1);
    for (int i = 0; i < c.length; i++) {
      c[i] = this[i];
    }
    return c;
  }

  ///  Concatenate X in to the current array
  ///  Examples
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0),
  ///  >>> Complex(real: 3.0, imaginary: 4.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 4.0)]);
  ///  >>> var b = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0)
  ///  >>> ]);
  ///  >>> list.concat(b);
  ///  ArrayComplex([
  ///    Complex(real: 3.0, imaginary: 4.0),
  ///    Complex(real: 3.0, imaginary: 4.0) ,
  ///    Complex(real: 3.0, imaginary: 4.0),
  ///    Complex(real: 3.0, imaginary: 4.0)
  ///  ])
  void concat(ArrayComplex x) {
    if (identical(this, x)) {
      throw FormatException(
          "you can't concat object with it self, use Obj.copy() to make this operation");
    }
    for (int i = 0; i < x.length; i++) {
      this.add(x[i]);
    }
  }

  ///  Concatenate X in to the start current array
  ///  Examples
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0),
  ///  >>> Complex(real: 3.0, imaginary: 4.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 4.0)]);
  ///  >>> var b = ArrayComplex([
  ///  >>> Complex(real: 1.0, imaginary: 4.0)
  ///  >>> ]);
  ///  >>> list.concat(b);
  ///  ArrayComplex([
  ///    Complex(real: 1.0, imaginary: 4.0),
  ///    Complex(real: 3.0, imaginary: 4.0),
  ///    Complex(real: 3.0, imaginary: 4.0),
  ///    Complex(real: 3.0, imaginary: 4.0)
  ///  ])
  void concatStart(ArrayComplex x) {
    var aux = this.copy();
    this.l = x.copy();
    this.concat(aux);
  }

  ///  Add zeros at begging of the array
  ///  Examples
  ///  >>> var list = ArrayComplex([
  ///  >>> Complex(real: 3.0, imaginary: 4.0),
  ///  >>> Complex(real: 3.0, imaginary: 4.0) ,
  ///  >>> Complex(real: 3.0, imaginary: 4.0)]);
  ///  >>> list.padStart(2)
  ///  ArrayComplex([
  ///    Complex(real: 0.0, imaginary: 0.0),
  ///    Complex(real: 0.0, imaginary: 0.0),
  ///    Complex(real: 3.0, imaginary: 4.0),
  ///    Complex(real: 3.0, imaginary: 4.0),
  ///    Complex(real: 3.0, imaginary: 4.0)
  ///  ])
  void padStart(int pad) {
    var aux = ArrayComplex.fixed(pad, initialValue: Complex());
    concatStart(aux);
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
