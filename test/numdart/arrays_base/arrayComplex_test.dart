import 'package:scidart/src/numdart/numdart.dart';
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

  test('getArrayRange', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0)]);
    var b = list.getRangeArray(0, 1);
    var bExpec = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0)
    ]);

    expect(b, bExpec);
  });
  //#endregion

  //#region methods overload
  test('toString', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0) ,
      Complex(real: 3.0, imaginary: 4.0)]);

    var str = list.toString();

    var strExpect = '\n'
        '  ArrayComplex([\n'
        '    Complex(real: 3.0, imaginary: 4.0), \n'
        '    Complex(real: 3.0, imaginary: 4.0), \n'
        '    Complex(real: 3.0, imaginary: 4.0)]\n'
        '  )';

    print(str);

    expect(str, strExpect);
  });
  //#endregion
}