import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arrayLog natual logarithm', () {
    var n = Array([0.1, 1, 10, 100]);
    var log = arrayLog(n);

    print(n);

    print(log);

    var logExp =
        Array([-2.3025850929940455, 0.0, 2.302585092994046, 4.605170185988092]);

    arrayTruncateEachElement(log, 5);
    arrayTruncateEachElement(logExp, 5);

    expect(log, logExp);
  });
}
