import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('toColumnMatrix', () {
    var a = Array([4.0, 4.0, 4.0]);
    var n = arrayToColumnMatrix(a);

    print(n);

    var nExp = Array2d([
      Array([4.0]),
      Array([4.0]),
      Array([4.0])
    ]);

    expect(n, nExp);
  });
}
