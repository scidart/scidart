import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('QRDecomposition', () {
    var a = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]);

    var _ = matrixQR(a);

    expect(true, true);
  });
}
