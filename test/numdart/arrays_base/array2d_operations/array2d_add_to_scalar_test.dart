import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('addEachElement', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    array2dAddToScalar(a, 2);

    print(a);

    var aExpec = Array2d([
      Array([4, 4, 4]),
      Array([4, 4, 4]),
      Array([4, 4, 4])
    ]);

    expect(a, aExpec);
  });
}
