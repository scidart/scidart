import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a Singular decomponsition object', () {
    var svd = Singular(Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]));

    var frac = 6;

    var uExp = Array2d([
      Array([0.06370191, 0.63944931, -0.76618969]),
      Array([0.24598854, 0.73399958, 0.63303575]),
      Array([0.96717718, -0.22879947, -0.11054003])
    ]);
    uExp.truncateEachElement(frac);

    var sExp = Array2d([
      Array([66.69193778, 0.0, 0.0]),
      Array([0.0, 2.66694684, 0.0]),
      Array([0.0, 0.0, 0.26986934]),
    ]);
    sExp.truncateEachElement(frac);

    var u = svd.U();
    u.truncateEachElement(frac);

    var s = svd.S();
    s.truncateEachElement(frac);

    print(u);
    print(s);

    expect(u, uExp);
    expect(s, sExp);
  });
}
