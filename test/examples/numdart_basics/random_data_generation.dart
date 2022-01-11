import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('random data generation', () {
    var r =
        randomArray(10); // generate an array with 10 random elements 0 to 0.99
    print(r);

    var r2d = randomArray2d(3, 3); // generate a 2D 3x3 with random elements
    print(r2d);

    var rAc =
        randomArrayComplex(10); // generate ArrayComplex with 10 random elements
    print(rAc);
  });
}
