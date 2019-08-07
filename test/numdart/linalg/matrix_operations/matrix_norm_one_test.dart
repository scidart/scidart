import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('norm1', () {
    var a = Array2d([
      Array([1, 2, 3]),
      Array([1, 2, 3]),
      Array([1, 2, 3]),
    ]);

    var norm = matrixNormOne(a);
    print(norm);

    var normExpec = 9;

    expect(norm, normExpec);
  });
}
