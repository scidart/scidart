import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('subtractEachElement', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    array2dSubToScalar(a, 2);

    print(a);

    var aExpec = Array2d([
      Array([0, 0, 0]),
      Array([0, 0, 0]),
      Array([0, 0, 0])
    ]);

    expect(a, aExpec);
  });
}
