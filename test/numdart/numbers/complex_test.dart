import 'package:scidart/numdart/numbers/complex.dart';
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

test('Conjugate positive imaginary complex numbers', () {
    var c1 = Complex(real: 1, imaginary: 1);
    var c2 = c1.conjugate();
    expect(c2.real, 1);
    expect(c2.imaginary, -1);
  });

  test('Conjugate negative imaginary complex numbers', () {
    var c1 = Complex(real: 1, imaginary: -1);
    var c2 = c1.conjugate();
    expect(c2.real, 1);
    expect(c2.imaginary, 1);
  });

  test('Conjugate zero negative imaginary complex numbers', () {
    var c1 = Complex(real: 1, imaginary: -0);
    var c2 = c1.conjugate();
    expect(c2.real, 1);
    expect(c2.imaginary, -0);
  });

  test('abs complex numbers', () {
    var c1 = Complex(real: 3.0, imaginary: 4.0);

    expect(c1.abs(), 5.0);
  });

  test('divide scalar complex numbers', () {
    var c1 = Complex(real: 2.0, imaginary: 2.0);
    c1 = c1.divideScalar(2);
    
    expect(c1.real, 1.0);
    expect(c1.imaginary, 1.0);
  });

  test('toString', () {
    var c1 = Complex(real: 1, imaginary: 1);

    expect(c1.toString(), 'Complex(real: ${c1.real}, imaginary: ${c1.imaginary})');
  });
}
