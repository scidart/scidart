import 'dart:collection';

import 'package:scidart/numdart/array/array.dart';
import 'package:scidart/numdart/numbers/complex.dart';

class ArrayComplex extends ListBase<Complex> {
  List<Complex> l = [];

  //#region constructors
  ArrayComplex();

  ArrayComplex.fromList(List<Complex> list) {
    l = list;
  }

  ArrayComplex.fromArray(ArrayComplex list) {
    l = list;
  }

  ArrayComplex.length(int length) {
    l = List<Complex>(length);
  }
  //#endregion

  //#region operators
  set length(int newLength) { l.length = newLength; }
  int get length => l.length;
  Complex operator [](int index) => l[index];
  void operator []=(int index, Complex value) { l[index] = value; }

  ArrayComplex operator *(ArrayComplex b) {
    if(this.length != b.length) {
      throw('both arrays need have the same dimesion');
    }

    var c = ArrayComplex.length(this.length);
    for(int i = 0; i < this.length; i++) {
      c[i] = this[i] * b[i];
    }

    return c;
  }
  //#endregion

  //#region array operations
  ArrayComplex multiplyArrayToScalar(num b) {
    var c = ArrayComplex.length(this.length);
    for(var i = 0; i < length; i++) {
      c[i] = this[i].multiplyScalar(b);
    }

    return c;
  }

  ArrayComplex divideArrayToScalar(num b) {
    var c = ArrayComplex.length(this.length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i].divideScalar(b);
    }

    return c;
  }

  List<Complex> conjugateArray() {
    var c = ArrayComplex.length(this.length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i].conjugate();
    }
    return c;
  }

  List<double> absArray() {
    var c = Array.length(this.length);
    for (var i = 0; i < length; i++) {
      c[i] = this[i].abs();
    }
    return c;
  }
  //#endregion

  //#region overload methods
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', ']');
    return 'ArrayComplex(${str})';
  }
  //#endregion
}