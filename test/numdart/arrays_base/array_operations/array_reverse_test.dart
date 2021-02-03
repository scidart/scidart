import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array reverse', () {
    var n = Array([1, 2, 3]);
    var o = arrayReverse(n);
    var oExpected = Array([3, 2, 1]);

    print(o);

    expect(o, oExpected);
  });
}
