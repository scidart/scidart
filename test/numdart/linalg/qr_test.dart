import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a QRDecomposition object', () {
    var qr = QR(Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]));

    var frac = 6;

    var qExp = Array2d([
      Array([-0.06052275, -0.6022239, -0.79602975]),
      Array([-0.24209101, -0.76482436, 0.59702231]),
      Array([-0.96836405, 0.22884508, -0.09950372])
    ]);
    array2dTruncateEachElement(qExp, frac);

    var rExp = Array2d([
      Array([-66.09084657, -8.83632198, -1.27097782]),
      Array([0.0, -2.43298457, -1.13820318]),
      Array([0.0, 0.0, -0.29851116]),
    ]);
    array2dTruncateEachElement(rExp, frac);

    var q = qr.Q();
    array2dTruncateEachElement(q, frac);

    var r = qr.R();
    array2dTruncateEachElement(r, frac);

    print(q);
    print(r);

    expect(q, qExp);
    expect(r, rExp);
  });
}
