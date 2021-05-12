import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array concatenation', () {
    var a = Array([1.0, 2.0, 3.0]);
    var b = Array([1.0, 2.0, 3.0]);
    var n = arrayConcat([a, b]);

    print(n);

    var nExp = Array([1.0, 2.0, 3.0, 1.0, 2.0, 3.0]);

    expect(n, nExp);
  });
}
