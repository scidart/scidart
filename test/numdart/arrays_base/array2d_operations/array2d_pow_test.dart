import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array2dPow', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    array2dPow(a, 2);

    print(a);

    var aExpec = Array2d([
      Array([4.0, 4.0, 4.0]),
      Array([4.0, 4.0, 4.0]),
      Array([4.0, 4.0, 4.0])
    ]);

    expect(a, aExpec);
  });
}
