import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arrayPow', () {
    var n = Array([4, 4, 4]);

    var pn = arrayPow(n, 2);

    print(pn);

    var pnExp = [16.0, 16.0, 16.0];

    expect(pn, pnExp);
  });
}
