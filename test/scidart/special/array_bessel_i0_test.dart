import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:scidart/src/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('array bessel i0', () {
    var i0 = arrayBesselI0(Array([0, 100, 0, 100]));
    print(i0);

    var i0Expec =
        Array([1.00000000e+00, 1.07375171e+42, 1.00000000e+00, 1.07375171e+42]);

    arrayTruncateEachElement(i0, 5);
    arrayTruncateEachElement(i0Expec, 5);

    expect(i0, i0Expec);
  });
}
