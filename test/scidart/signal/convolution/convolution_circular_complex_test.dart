import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/signal/signal.dart';
import 'package:test/test.dart';

void main() {
  test('convolve two periodic signals', () {
    var input = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
    var kernel = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
    var xi = input.toComplexArray();
    var yi = kernel.toComplexArray();

    print(convolutionCircularComplex(xi, yi));

    var zi = convolutionCircularComplex(xi, yi).abs();
    zi.truncateEachElement(4);

    kernel.concat(kernel.copy());
    var ziExpec = convolution(input, kernel);

    print(zi);
    print(zi.length);

    print(ziExpec);
    print(ziExpec.length);

    expect(zi, ziExpec);
  });
}
