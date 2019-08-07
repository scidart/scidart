import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('multiply matrix', () {
    var a = Array2d([
      Array([4, 2, 1]),
      Array([16, 4, 1]),
      Array([64, 8, 1])
    ]);

    var b = Array2d([
      Array([1]),
      Array([1]),
      Array([1])
    ]);

    var c = matrixDot(a, b);

    var cExpec = Array2d([
      Array([7]),
      Array([21]),
      Array([73])
    ]);

    expect(c, cExpec);
  });
}
