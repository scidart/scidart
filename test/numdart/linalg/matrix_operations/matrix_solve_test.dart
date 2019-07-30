import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('solve', () {
    var a = Array2d([
      Array([3.0, 1.0]),
      Array([1.0, 2.0])
    ]);

    var b = Array2d([
      Array([9.0]),
      Array([8.0])
    ]);

    var x = matrixSolve(a, b);

    var xExp = Array2d([
      Array([2]),
      Array([3])
    ]);

    print(x);

    expect(x, xExp);
  });

  test('solve2', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var frac = 6;

    var b = Array2d([
      Array([9.0]),
      Array([4.0]),
      Array([6.0])
    ]);

    var x = matrixSolve(a, b);
    array2dTruncateEachElement(x, frac);

    var xExp = Array2d([
      Array([-5.33333333]),
      Array([-3.33333333]),
      Array([7.0])
    ]);
    array2dTruncateEachElement(xExp, frac);

    print(x);

    expect(x, xExp);
  });
}
