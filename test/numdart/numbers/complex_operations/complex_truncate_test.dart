import 'package:scidart/numdart/numbers/complex_operations/complex_truncate.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('complexTruncate a number', () {
    var n =
        complexTruncate(Complex.ri(1.4747474747474747, 1.4747474747474747), 3);
    expect(n, Complex(real: 1.475, imaginary: 1.475));
  });
}
