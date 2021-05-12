import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('pad start with zeros', () {
    var a = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0)
    ]);

    var b = arrayComplexPadStart(a, 2);

    var bExpec = ArrayComplex([
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0)
    ]);

    expect(b, bExpec);
  });
}
