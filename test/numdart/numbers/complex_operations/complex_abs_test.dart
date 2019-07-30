import 'package:scidart/numdart/numbers/complex_operations/complex_abs.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('abs complex numbers', () {
    var c1 = Complex(real: 3.0, imaginary: 4.0);

    expect(complexAbs(c1), 5.0);
  });
}
