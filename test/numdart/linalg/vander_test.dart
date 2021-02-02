import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a Vandermonde matrix', () {
    var x = Array([2.0, 4.0, 8.0]);
    var v = matrixVander(x);

    var vExpect = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]);

    expect(v, vExpect);
  });

  test('create a Vandermonde matrix increasing', () {
    var x = Array([2.0, 4.0, 8.0]);
    var v = matrixVander(x, increasing: true);

    var vExpect = Array2d([
      Array([1.0, 2.0, 4.0]),
      Array([1.0, 4.0, 16.0]),
      Array([1.0, 8.0, 64.0])
    ]);

    expect(v, vExpect);
  });

  test('create a Vandermonde matrix N = 2', () {
    var x = Array([2.0, 4.0, 8.0]);
    var v = matrixVander(x, N: 2);

    var vExpect = Array2d([
      Array([2.0, 1.0]),
      Array([4.0, 1.0]),
      Array([8.0, 1.0])
    ]);

    expect(v, vExpect);
  });
}
