import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:scidart/src/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('array bessel i0', () {
    var i0 = arrayBesselI0(Array([0, 100, 0, 100]));
    print(i0);

    // scipy.special.i0; besselI0 uses the Abramowitz and Stegun polynomial
    // approximation, so large arguments are compared with relative tolerance
    var i0Expec = [1.0, 1.0737517071310738e+42, 1.0, 1.0737517071310738e+42];

    expect(i0.length, i0Expec.length);
    for (var i = 0; i < i0Expec.length; i++) {
      expect(i0[i], closeTo(i0Expec[i], i0Expec[i] * 1e-6));
    }
  });
}
