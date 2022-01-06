import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('Numeric spaces', () {
    var ar = arange(step: 0, stop: 100); // generate an array 0 to 99
    print(ar);

    var lin =
        linspace(0, 10, num: 40); // generate an array 0 to 10 with 40 elements
    print(lin);

    var on =
        ones(10); // generate an array with length 10 where all elements are 1
    print(on);

    var zer =
        zeros(5); // generate an array with length 5 where all elements are 0
    print(zer);

    // generate a 1Hz sine wave with sample frequency (fs) of 128Hz
    var N = 50.0;
    var fs = 128;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);
    var f1 = 1; // 1Hz
    var sg = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));
    print(sg);
  });
}
