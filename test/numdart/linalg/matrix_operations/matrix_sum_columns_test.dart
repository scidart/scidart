import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('sumColumns', () {
    var a = Array2d([
      Array([1, 1, 1]),
      Array([1, 1, 1]),
      Array([1, 1, 1])
    ]);

    var b = matrixSumColumns(a);

    print(b);

    var bExpec = Array([3, 3, 3]);

    expect(b, bExpec);
  });
}
