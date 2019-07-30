import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('subMatrixFromArray', () {
    var a = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]);

    var subA = matrixSubFromArray(a, Array([0, 1]), 0, 2);

    var subAExp = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0])
    ]);

    print(subA);

    expect(subA, subAExp);
  });
}
