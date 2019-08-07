import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('transpose', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var t = matrixTranspose(a);

    var tExp = Array2d([
      Array([1.0, 4.0, 7.0]),
      Array([2.0, 5.0, 8.0]),
      Array([3.0, 6.0, 10.0])
    ]);

    print(t);

    expect(t, tExp);
  });
}
