import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('complex operations', () {
    var a = Complex(real: 1.121212, imaginary: 2.22222);
    var b = Complex.ri(4.0, 8.0);

    print(a + b);
    print(a - b);
    print(a * b);
    print(a / b);

    print(complexAbs(a));
    print(complexConjugate(a));
    print(complexCos(a));
    print(complexDivideScalar(a, 2));
    print(complexMultiplyScalar(a, 2));
    print(complexExp(a));
    print(complexTruncate(a, 2));
  });
}
