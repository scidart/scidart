import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array reshape to matrix', () {
    var a = Array([1.0, 2.0, 3.0, 4.0]);
    var n = arrayReshapeToMatrix(a, 2);

    print(n);

    var nExp = Array2d([
      Array([1.0, 2.0]),
      Array([3.0, 4.0])
    ]);

    expect(n, nExp);
  });

  test('array 2 length reshape to matrix', () {
    var a = Array([1.0, 2.0]);
    var n = arrayReshapeToMatrix(a, 2);

    print(n);

    var nExp = Array2d([
      Array([1.0, 2.0])
    ]);

    expect(n, nExp);
  });
}
