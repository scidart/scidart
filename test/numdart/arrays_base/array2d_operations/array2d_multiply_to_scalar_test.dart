import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('multiplyEachElement', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    array2dMultiplyToScalar(a, 4);

    print(a);

    var aExpec = Array2d([
      Array([8, 8, 8]),
      Array([8, 8, 8]),
      Array([8, 8, 8])
    ]);

    expect(a, aExpec);
  });
}
