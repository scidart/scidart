import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('mode', () {
    var a = Array([1.0, 2.0, 3.0, 3]);
    var n = mode(a);

    print(n);

    var nExp = 3.0;

    expect(n, nExp);
  });
}
