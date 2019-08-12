import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('subMatrix', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var b = matrixSub(a, 0, 1, 0, 1);

    print(b);

    var bExpec = Array2d([
      Array([2, 2]),
      Array([2, 2])
    ]);

    expect(b, bExpec);
  });
}
