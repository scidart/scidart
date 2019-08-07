import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array arg max', () {
    var a = Array([1.0, 2.0, 3.0]);
    var n = arrayArgMax(a);

    print(n);

    var nExp = 2;

    expect(n, nExp);
  });
}
