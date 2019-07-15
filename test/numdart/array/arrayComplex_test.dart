import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  //#region operators tests
  test('set get length', () {
    var list = ArrayComplex([
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0) ,
      Complex(real: 2.0, imaginary: 2.0)]);
    print(list);

    expect(list.length, 3);

    list.length = 4;
    print(list);

    expect(list.length, 4);

    list.length = 2;
    print(list);

    expect(list.length, 2);

  });

  test('index operator', () {
    var list = ArrayComplex([
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0) ,
      Complex(real: 2.0, imaginary: 2.0)]);

    expect(list[0], Complex.ri(2.0, 2.0));

    list[0] = Complex.ri(10.0, 10.0);

    expect(list[0], Complex.ri(10.0, 10.0));
    expect(list[0], Complex.ri(10.0, 10.0));
  });

  test('create and mutiply arrays', () {
    var list = ArrayComplex([
      Complex(real: 2, imaginary: 5),
      Complex(real: 2, imaginary: 5) ,
      Complex(real: 2, imaginary: 5)]);
    var list2 = ArrayComplex([
      Complex(real: 4, imaginary: -3),
      Complex(real: 4, imaginary: -3),
      Complex(real: 4, imaginary: -3)]);

    var cList = list * list2;

    print(cList);

    expect(cList.elementAt(0), Complex(real: 23, imaginary: 14));
    expect(cList.elementAt(1), Complex(real: 23, imaginary: 14));
    expect(cList.elementAt(2), Complex(real: 23, imaginary: 14));
  });
  //#endregion

  //#region array operations tests
  test('multiplyArrayToScalar', () {
    var list = ArrayComplex([
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0) ,
      Complex(real: 2.0, imaginary: 2.0)]);

    var cList = list.multiplyToScalar(2);

    print(cList);

    expect(cList.elementAt(0).real, 4.0);
    expect(cList.elementAt(0).imaginary, 4.0);

    expect(cList.elementAt(1).real, 4.0);
    expect(cList.elementAt(1).imaginary, 4.0);

    expect(cList.elementAt(2).real, 4.0);
    expect(cList.elementAt(2).imaginary, 4.0);
  });

  test('divideArrayToScalar', () {
    var list = ArrayComplex([
      Complex(real: 4.0, imaginary: 4.0),
      Complex(real: 8.0, imaginary: 8.0) ,
      Complex(real: 16.0, imaginary: 16.0)]);

    var cList = list.divisionToScalar(2);

    print(cList);

    expect(cList.elementAt(0).real, 2.0);
    expect(cList.elementAt(0).imaginary, 2.0);

    expect(cList.elementAt(1).real, 4.0);
    expect(cList.elementAt(1).imaginary, 4.0);

    expect(cList.elementAt(2).real, 8.0);
    expect(cList.elementAt(2).imaginary, 8.0);
  });

  test('create and sum arrays', () {
    var list = ArrayComplex([
      Complex(real: 1, imaginary: 1),
      Complex(real: 1, imaginary: 1) ,
      Complex(real: 1, imaginary: 1)]);
    var list2 = ArrayComplex([
      Complex(real: 1, imaginary: 1),
      Complex(real: 1, imaginary: 1),
      Complex(real: 1, imaginary: 1)]);

    var cList = list.sum(list2);

    print(cList);

    expect(cList.elementAt(0), Complex(real: 2, imaginary: 2));
    expect(cList.elementAt(1), Complex(real: 2, imaginary: 2));
    expect(cList.elementAt(2), Complex(real: 2, imaginary: 2));
  });

  test('conjugateArray', () {
    var list = ArrayComplex([
      Complex(real: 1.0, imaginary: 1.0),
      Complex(real: 2.0, imaginary: 2.0) ,
      Complex(real: 3.0, imaginary: 3.0) ]);

    var cList = list.conjugate();

    print(cList);

    expect(cList.elementAt(0).real, 1.0);
    expect(cList.elementAt(0).imaginary, -1.0);

    expect(cList.elementAt(1).real, 2.0);
    expect(cList.elementAt(1).imaginary, -2.0);

    expect(cList.elementAt(2).real, 3.0);
    expect(cList.elementAt(2).imaginary, -3.0);
  });

  test('absList', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0) ,
      Complex(real: 3.0, imaginary: 4.0)]);

    var cList = list.abs();

    print(cList);

    expect(cList.elementAt(0), 5.0);
    expect(cList.elementAt(1), 5.0);
    expect(cList.elementAt(2), 5.0);
  });

  test('truncateLast', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0) ,
      Complex(real: 3.0, imaginary: 4.0)]);

    var cList = list.truncateLast();

    print(cList);

    expect(cList.length, 2.0);

    expect(cList.elementAt(0), Complex(real: 3.0, imaginary: 4.0));
    expect(cList.elementAt(1), Complex(real: 3.0, imaginary: 4.0));
  });

  test('cos', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0) ,
      Complex(real: 3.0, imaginary: 4.0)]);

    var cList = list.cos();

    print(cList);

    expect(cList.elementAt(0), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775));
    expect(cList.elementAt(1), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775));
    expect(cList.elementAt(2), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775));
  });
  //#endregion

  //#region methods overload
  test('toString', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0) ,
      Complex(real: 3.0, imaginary: 4.0)]);

    var str = list.toString();

    var strExpect = "ArrayComplex([Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0), Complex(real: 3.0, imaginary: 4.0)])";

    print(str);

    expect(str, strExpect);
  });
  //#endregion
}