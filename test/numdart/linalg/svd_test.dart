import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a Singular decomponsition object', () {
    var svd = SVD(Array2d([
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
    array2dTruncateEachElement(uExp, frac);

    var sExp = Array2d([
      Array([66.69193778, 0.0, 0.0]),
      Array([0.0, 2.66694684, 0.0]),
      Array([0.0, 0.0, 0.26986934]),
    ]);
    array2dTruncateEachElement(sExp, frac);

    var u = svd.U();
    array2dTruncateEachElement(u, frac);

    var s = svd.S();
    array2dTruncateEachElement(s, frac);

    print(u);
    print(s);

    expect(u, uExp);
    expect(s, sExp);
  });

  test('svd 2', () {
    var svd = SVD(Array2d([
      Array([1, 2, 3]),
      Array([4, 5, 6])
    ]));

    var frac = 6;

    var uExp = Array2d([
      Array([0.386318, -0.922366]),
      Array([0.922366, 0.386318])
    ]);
    array2dTruncateEachElement(uExp, frac);

    var sExp = Array2d([
      Array([9.5080320006957, 0.0, 0.0]),
      Array([0.0, 0.77286963567348, 0.0]),
    ]);
    array2dTruncateEachElement(sExp, frac);

    var vExp = Array2d([
      Array([0.428667, 0.805964, 0.408248]),
      Array([0.566307, 0.112382, -0.816497]),
      Array([0.703947, -0.581199, 0.408248]),
    ]);
    array2dTruncateEachElement(vExp, frac);

    var u = svd.U();
    array2dTruncateEachElement(u, frac);

    var s = svd.S();
    array2dTruncateEachElement(s, frac);

    var v = svd.V();
    array2dTruncateEachElement(v, frac);

    print(u);
    print(s);
    print(v);

    expect(u, uExp);
    expect(s, sExp);
    expect(v, vExp);
  });

  test('svd 3', () {
    var svd = SVD(Array2d([
      Array([1, 2]),
      Array([3, 4])
    ]));

    var frac = 5;

    var uExp = Array2d([
      Array([0.40455359, 0.91451431]),
      Array([0.9145143, -0.40455355])
    ]);
    array2dTruncateEachElement(uExp, frac);

    var sExp = Array2d([
      Array([5.4649857, 0]),
      Array([0, 0.36596619]),
    ]);
    array2dTruncateEachElement(sExp, frac);

    var vExp = Array2d([
      Array([0.57604844, -0.81741556]),
      Array([0.81741556, 0.57604844])
    ]);
    array2dTruncateEachElement(vExp, frac);

    var u = svd.U();
    array2dTruncateEachElement(u, frac);

    var s = svd.S();
    array2dTruncateEachElement(s, frac);

    var v = svd.V();
    array2dTruncateEachElement(v, frac);

    print(u);
    print(s);
    print(v);

    expect(u, uExp);
    expect(s, sExp);
    expect(v, vExp);
  });

  test('svd 4', () {
    var svd = SVD(Array2d([
      Array([1, 2]),
      Array([3, 4]),
      Array([5, 6])
    ]));

    var frac = 4;

    var uExp = Array2d([
      Array([0.229848, 0.883461, 0.408248]),
      Array([0.524745, 0.240782, -0.816497]),
      Array([0.819642, -0.401896, 0.408248])
    ]);
    array2dTruncateEachElement(uExp, frac);

    var sExp = Array2d([
      Array([9.52552, 0]),
      Array([0, 0.514301]),
      Array([0, 0])
    ]);
    array2dTruncateEachElement(sExp, frac);

    var vExp = Array2d([
      Array([0.619629, -0.784894]),
      Array([0.784894, 0.619629])
    ]);
    array2dTruncateEachElement(vExp, frac);

    var u = svd.U();
    array2dTruncateEachElement(u, frac);

    var s = svd.S();
    array2dTruncateEachElement(s, frac);

    var v = svd.V();
    array2dTruncateEachElement(v, frac);

    print(u);
    print(s);
    print(v);

    expect(u, uExp);
    expect(s, sExp);
    expect(v, vExp);
  });
}
