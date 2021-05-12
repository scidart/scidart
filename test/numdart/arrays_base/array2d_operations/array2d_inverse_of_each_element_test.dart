import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array2dInverseOfEachElement', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    array2dInverseOfEachElement(a);

    print(a);

    var aExpec = Array2d([
      Array([0.5, 0.5, 0.5]),
      Array([0.5, 0.5, 0.5]),
      Array([0.5, 0.5, 0.5])
    ]);

    expect(a, aExpec);
  });
}
