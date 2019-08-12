import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('cos', () {
    var c1 = Complex(real: 3.0, imaginary: 4.0);
    c1 = complexCos(c1);

    print(c1);

    expect(truncate(c1.real, 5), truncate(-27.034945603074, 5));
    expect(truncate(c1.imaginary, 5), truncate(-3.8511533348118, 5));
  });
}
