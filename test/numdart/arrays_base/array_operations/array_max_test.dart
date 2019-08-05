import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array max', () {
    var a = Array([1.0, 2.0, 3.0]);
    var n = arrayMax(a);

    print(n);

    var nExp = 3.0;

    expect(n, nExp);
  });
}
