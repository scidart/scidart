import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('cum sum', () {
    var a = Array([1.0, 2.0, 3.0]);
    var n = arrayCumSum(a);

    print(n);

    var nExp = Array([1.0, 3.0, 6.0]);

    expect(n, nExp);
  });
}
