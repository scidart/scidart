import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array reshape to matrix', () {
    var a = Array([4.0, 4.0, 4.0, 4.0]);
    var n = arrayReshapeToMatrix(a, 2);

    print(n);

    var nExp = Array2d([
      Array([4.0, 4.0]),
      Array([4.0, 4.0])
    ]);

    expect(n, nExp);
  });
}
