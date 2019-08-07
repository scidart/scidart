import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('determiant 2x2', () {
    var a = Array2d([
      Array([4, 6]),
      Array([3, 8])
    ]);

    var det = matrixDeterminant(a);

    var detExp = 14;

    expect(det, detExp);
  });

  test('determiant 3x3', () {
    var a = Array2d([
      Array([6, 1, 1]),
      Array([4, -2, 5]),
      Array([2, 8, 7])
    ]);

    var det = matrixDeterminant(a);

    var detExp = -306;

    expect(det, detExp);
  });
}
