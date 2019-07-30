import 'package:scidart/numdart/numbers/complex_operations/complex_conjugate.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('Conjugate positive imaginary complex numbers', () {
    var c1 = Complex(real: 1, imaginary: 1);
    var c2 = complexConjugate(c1);
    expect(c2.real, 1);
    expect(c2.imaginary, -1);
  });

  test('Conjugate negative imaginary complex numbers', () {
    var c1 = Complex(real: 1, imaginary: -1);
    var c2 = complexConjugate(c1);
    expect(c2.real, 1);
    expect(c2.imaginary, 1);
  });

  test('Conjugate zero negative imaginary complex numbers', () {
    var c1 = Complex(real: 1, imaginary: -0);
    var c2 = complexConjugate(c1);
    expect(c2.real, 1);
    expect(c2.imaginary, -0);
  });
}
