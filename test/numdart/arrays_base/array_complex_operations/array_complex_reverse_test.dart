import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array complex reverse', () {
    var n = ArrayComplex([
      Complex(real: 1, imaginary: 1),
      Complex(real: 2, imaginary: 2),
      Complex(real: 3, imaginary: 3)
    ]);
    var o = arrayComplexReverse(n);

    var oExpected = ArrayComplex([
      Complex(real: 3, imaginary: 3),
      Complex(real: 2, imaginary: 2),
      Complex(real: 1, imaginary: 1)
    ]);

    print(o);

    expect(o, oExpected);
  });
}
