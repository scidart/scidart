import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('inverse', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var frac = 6;

    var i = matrixInverse(a);
    array2dTruncateEachElement(i, frac);

    var iExp = Array2d([
      Array([-0.66666667, -1.33333333, 1.0]),
      Array([-0.66666667, 3.66666667, -2.0]),
      Array([1.0, -2.0, 1.0])
    ]);
    array2dTruncateEachElement(iExp, frac);

    print(i);

    expect(i, iExp);
  });
}
