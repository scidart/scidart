import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('sqrt', () {
    var n = Array([4, 4, 4]);
    var nsqrt = arraySqrt(n);

    print(nsqrt);

    var nsqrtExp = Array([2, 2, 2]);

    expect(nsqrt, nsqrtExp);
  });
}
