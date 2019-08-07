import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('complexTruncate a number', () {
    var n =
        complexTruncate(Complex.ri(1.4747474747474747, 1.4747474747474747), 3);
    expect(n, Complex(real: 1.475, imaginary: 1.475));
  });
}
