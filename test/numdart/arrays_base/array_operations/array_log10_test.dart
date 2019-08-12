import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arrayLog10', () {
    var n = Array([0.1, 1, 10, 100]);
    var log = arrayLog10(n);

    print(n);

    print(log);

    var logExp = Array([-1.0, 0.0, 1.0, 2.0]);

    arrayTruncateEachElement(log, 5);
    arrayTruncateEachElement(logExp, 5);

    expect(log, logExp);
  });
}
