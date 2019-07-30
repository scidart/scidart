import 'package:scidart/numdart/numbers/complex.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  // https://pub.dev/packages/test#running-tests
  
  test('Empty constructor complex numbers', () {
    var c1 = Complex();
    expect(c1.real, 0);
    expect(c1.imaginary, 0);
  });
  
  test('Sum complex numbers', () {
    var c1 = Complex(real: 1, imaginary: 1);
    var c2 = Complex(real: 1, imaginary: 1);
    var c3 = c1 + c2;
    expect(c3.real, 2);
    expect(c3.imaginary, 2);
  });

  test('Sub complex numbers', () {
    var c1 = Complex(real: 1, imaginary: 1);
    var c2 = Complex(real: 1, imaginary: 1);
    var c3 = c1 - c2;
    expect(c3.real, 0);
    expect(c3.imaginary, 0);
  });

  test('multiply complex numbers', () {
    // https://www.chilimath.com/lessons/advanced-algebra/multiplying-complex-numbers/
    var c1 = Complex(real: 2, imaginary: 5);
    var c2 = Complex(real: 4, imaginary: -3);
    var c3 = c1 * c2;
    expect(c3.real, 23);
    expect(c3.imaginary, 14);
  });

  test('division complex numbers', () {
    // https://www.chilimath.com/lessons/advanced-algebra/dividing-complex-numbers/
    var c1 = Complex(real: 1, imaginary: -3);
    var c2 = Complex(real: 1, imaginary: 2);
    var c3 = c1 / c2;
    expect(c3.real, -1);
    expect(c3.imaginary, -1);
  });

  test('division complex numbers', () {
    // https://www.chilimath.com/lessons/advanced-algebra/dividing-complex-numbers/
    var c1 = Complex(real: 7, imaginary: 4);
    var c2 = Complex(real: -3, imaginary: -1);
    var c3 = c1 / c2;
    expect(c3.real, -5/2);
    expect(c3.imaginary, -1/2);
  });

  test('toString', () {
    var c1 = Complex(real: 1, imaginary: 1);

    expect(c1.toString(), '\n' + '    Complex(real: 1.0, imaginary: 1.0)');
  });
}
