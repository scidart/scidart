import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('interpolation', () {
    // genrate a x range -3 to 3
    var x = linspace(-3, 3, num: 30);
    // generate parabolic equation: y = 5 - 0.555*x^2
    var y = Array.fixed(x.length, initialValue: 5) -
        arrayMultiplyToScalar(arrayPow(x, 2), 0.555);
    // estimate the inter-sample points vx and vy around the maximum point
    // of y function
    var xMax = arrayArgMax(y);
    var yMax = arrayMax(y);

    print('Array points:');
    print('$xMax, $yMax');

    print('Estimated points:');
    print(parabolic(y, xMax));
  });
}
