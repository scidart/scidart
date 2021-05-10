import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('complex natural exponent', () {
    var c1 = Complex(real: 2.0, imaginary: 2.0);
    c1 = complexExp(c1);

    print(c1);

    expect(c1.real, -3.074932320639359);
    expect(c1.imaginary, 6.71884969742825);
  });
}
