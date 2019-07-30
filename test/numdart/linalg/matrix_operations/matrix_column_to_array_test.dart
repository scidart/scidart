import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('columnToArray', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var b = matrixColumnToArray(a, 2);

    var bExp = Array([3.0, 6.0, 10.0]);

    print(b);

    expect(b, bExp);
  });
}
