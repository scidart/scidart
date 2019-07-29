import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a LUDecomposition object', () {
    var lu = LU(Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]));

    var frac = 6;

    var lExp = Array2d([
      Array([1.0, 0.0, 0.0]),
      Array([0.25, 1.0, 0.0]),
      Array([0.0625, 0.75, 1.0])
    ]);

    array2dTruncateEachElement(lExp, frac);

    var uExp = Array2d([
      Array([64.0, 8.0, 1.0]),
      Array([0.0, 2.0, 0.75]),
      Array([0.0, 0.0, 0.375]),
    ]);
    array2dTruncateEachElement(uExp, frac);

    var l = lu.L();
    array2dTruncateEachElement(l, frac);

    var u = lu.U();
    array2dTruncateEachElement(u, frac);

    print(l);
    print(u);

    expect(l, lExp);
    expect(u, uExp);
  });
}
