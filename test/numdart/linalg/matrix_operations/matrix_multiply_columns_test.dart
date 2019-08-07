import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('multiply column', () {
    var a = Array2d([
      Array([4, 2, 1]),
      Array([16, 4, 1]),
      Array([64, 8, 1])
    ]);

    var b = Array([2, 2, 2]);

    var c = matrixMultiplyColumns(a, b);

    var cExp = Array2d([
      Array([8.0, 4.0, 2.0]),
      Array([32.0, 8.0, 2.0]),
      Array([128.0, 16.0, 2.0])
    ]);

    expect(c, cExp);
  });
}
