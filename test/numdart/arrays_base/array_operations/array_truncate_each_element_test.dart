import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('truncateEachElement', () {
    var n = Array([4.123456789, 4.123456789, 4.123456789]);
    arrayTruncateEachElement(n, 4);

    print(n);

    var nExp = Array([4.1235, 4.1235, 4.1235]);

    expect(n, nExp);
  });
}
