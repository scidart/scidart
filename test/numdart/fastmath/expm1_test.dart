import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('expm1', () {
    var a = expm1(1);
    var aExpec = 2.718281828459045 - 1;

    print(a);

    expect(truncate(a, 5), truncate(aExpec, 5));
  });
}
