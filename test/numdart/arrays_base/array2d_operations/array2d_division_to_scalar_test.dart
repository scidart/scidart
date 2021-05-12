import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('divideEachElement', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    array2dDivisionToScalar(a, 2);

    print(a);

    var aExpec = Array2d([
      Array([1, 1, 1]),
      Array([1, 1, 1]),
      Array([1, 1, 1])
    ]);

    expect(a, aExpec);
  });
}
