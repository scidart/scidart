import 'package:scidart/scidart.dart';
import 'package:scidart/src/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('bessel i0 100', () {
    var i0 = besselI0(100);
    print(i0);

    var i0Expec = 1.07375171e+42;

    expect(truncate(i0, 5), truncate(i0Expec, 5));
  });

  test('bessel i0 0', () {
    var i0 = besselI0(0);
    print(i0);

    var i0Expec = 1.00000000e+00;

    expect(truncate(i0, 5), truncate(i0Expec, 5));
  });
}
