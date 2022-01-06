import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create an identity matrix', () {
    var i = matrixIdentity(3, 3);

    print(i);

    var iExpect = Array2d([
      Array([1.0, 0.0, 0.0]),
      Array([0.0, 1.0, 0.0]),
      Array([0.0, 0.0, 1.0])
    ]);

    expect(i, iExpect);
  });
}
