import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('sum', () {
    var a = Array([1.0, 2.0, 3.0]);
    var n = arraySum(a);

    print(n);

    var nExp = 6.0;

    expect(n, nExp);
  });
}
