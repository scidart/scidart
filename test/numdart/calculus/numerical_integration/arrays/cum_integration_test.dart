import 'package:scidart/numdart/calculus/numerical_integration/arrays/cum_integration.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('cum integration', () {
    var x = linspace(-2, 2, num: 20);
    var y = x.copy();

    var b = cumIntegration(y, x: x, initial: 0);
    var bExpect = Array([
      0.00000000e+00,
      -3.98891967e-01,
      -7.53462604e-01,
      -1.06371191e+00,
      -1.32963989e+00,
      -1.55124654e+00,
      -1.72853186e+00,
      -1.86149584e+00,
      -1.95013850e+00,
      -1.99445983e+00,
      -1.99445983e+00,
      -1.95013850e+00,
      -1.86149584e+00,
      -1.72853186e+00,
      -1.55124654e+00,
      -1.32963989e+00,
      -1.06371191e+00,
      -7.53462604e-01,
      -3.98891967e-01,
      -2.77555756e-16
    ]);

    arrayTruncateEachElement(b, 4);
    arrayTruncateEachElement(bExpect, 4);

    print(b);
    print(b.length);

    print(y);
    print(y.length);

    expect(b, bExpect);
  });

  test('cum integration only y and only initial', () {
    var y = Array([1, 2, 3]);
    var yI = cumIntegration(y);

    print(yI);

    var yIExpec = Array([1.5, 4.0]);

    expect(yI, yIExpec);

    yI = cumIntegration(y, initial: 1);

    print(yI);

    yIExpec = Array([1, 1.5, 4.0]);

    expect(yI, yIExpec);
  });
}
