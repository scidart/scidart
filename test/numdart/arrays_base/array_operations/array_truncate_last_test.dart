import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('truncateLast', () {
    var n = Array([1, 2, 3]);

    var n2 = arrayTruncateLast(n);

    var n2Exp = Array([1, 2]);

    expect(n2.length, isNot(n.length));

    for (var i = 0; i < n2.length; i++) {
      expect(truncate(n2[i], 4), truncate(n2Exp[i], 4));
    }
  });
}
