import 'package:scidart/numdart/numbers/complex_operations/complex_divide_scalar.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('divide scalar complex numbers', () {
    var c1 = Complex(real: 2.0, imaginary: 2.0);
    c1 = complexDivideScalar(c1, 2);

    expect(c1.real, 1.0);
    expect(c1.imaginary, 1.0);
  });
}
