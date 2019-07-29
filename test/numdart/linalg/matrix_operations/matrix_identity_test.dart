import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a identity matrix', () {
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
