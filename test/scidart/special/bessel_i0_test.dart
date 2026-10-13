import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:scidart/src/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('bessel i0 100', () {
    var i0 = besselI0(100);
    print(i0);

    // scipy.special.i0(100); besselI0 uses the Abramowitz and Stegun
    // polynomial approximation, so the comparison uses relative tolerance
    var i0Expec = 1.0737517071310738e+42;

    expect(i0, closeTo(i0Expec, i0Expec * 1e-6));
  });

  test('bessel i0 0', () {
    var i0 = besselI0(0);
    print(i0);

    var i0Expec = 1.00000000e+00;

    expect(truncate(i0, 5), truncate(i0Expec, 5));
  });
}
