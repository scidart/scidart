import 'package:scidart/scidart.dart';
import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('convolve two signals', () {
    var xi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
    var yi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
    var zi = convolution(xi, yi);
    print(zi);
    print(zi.length);

    var ziExpec = Array([
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      9.0,
      8.0,
      7.0,
      6.0,
      5.0,
      4.0,
      3.0,
      2.0,
      1.0
    ]);

    expect(zi, ziExpec);
  });

  test('convolve two signals using fast mode', () {
    var xi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
    var yi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
    var zi = convolution(xi, yi, fast: true);

    print(zi);
    print(zi.length);

    var ziExpec = Array([
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      9.0,
      8.0,
      7.0,
      6.0,
      5.0,
      4.0,
      3.0,
      2.0,
      1.0
    ]);

    arrayTruncateEachElement(zi, 6);
    arrayTruncateEachElement(ziExpec, 6);
    expect(zi, ziExpec);
  });
}
