import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('special', () {
    // modified Bessel function of order 0
    print(besselI0(10));

    // modified Bessel function of order 0 for an Array
    var a = randomArray(10);
    print(arrayBesselI0(a));
  });
}
