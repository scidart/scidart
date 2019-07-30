import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('norm2', () {
    var a = Array2d([
      Array([1, 2, 3]),
      Array([1, 2, 3]),
      Array([1, 2, 3]),
    ]);

    var norm = truncate(matrixNormTwo(a), 4);
    print(norm);

    var normExpec = 6.4807;

    expect(norm, normExpec);
  });
}
