import 'package:scidart/scidart.dart';
import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('test cross-correlation case 1', () {
    var x = ArrayComplex([
      Complex(real: 1, imaginary: 1),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0)
    ]);
    var y = ArrayComplex([
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 1, imaginary: 1)
    ]);

    var z = correlateComplex(x, y);

    var zExpec = ArrayComplex([
      Complex(real: 2.0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0)
    ]);

    arrayComplexTruncateEachElement(z, 2);

    print(z);

    expect(z, zExpec);
  });

  test('test cross-correlation case 2', () {
    var x = ArrayComplex([
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 1, imaginary: 1)
    ]);
    var y = ArrayComplex([
      Complex(real: 1, imaginary: 1),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0)
    ]);

    var z = correlateComplex(x, y);

    var zExpec = ArrayComplex([
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 2.0, imaginary: 0)
    ]);

    arrayComplexTruncateEachElement(z, 2);

    print(z);

    expect(z, zExpec);
  });

  test('test cross-correlation case 3', () {
    var x = ArrayComplex([
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 1, imaginary: 1),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0)
    ]);
    var y = ArrayComplex([
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 1, imaginary: 1),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0)
    ]);

    var z = correlateComplex(x, y);

    var zExpec = ArrayComplex([
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 2.0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0),
      Complex(real: 0, imaginary: 0)
    ]);

    arrayComplexTruncateEachElement(z, 2);

    print(z);

    expect(z, zExpec);
  });
}
