import 'package:scidart/numdart/arrays_base/array.dart';
import 'package:scidart/numdart/arrays_base/array_operations/array_truncate_each_element.dart';
import 'package:scidart/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('array bessel i0', () {
    var i0 = arrayBesselI0(Array([0, 100, 0, 100]));
    print(i0);

    var i0Expec =
        Array([1.00000000e+00, 1.07375171e+42, 1.00000000e+00, 1.07375171e+42]);

    expect(
        arrayTruncateEachElement(i0, 5), arrayTruncateEachElement(i0Expec, 5));
  });
}
