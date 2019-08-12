import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('trapz func', () {
    var i = trapzFunction(0, 2 * pi, 20, (x) => cos(x));
    i = truncate(i, 4);
    print(i);

    var iExpect = 0;

    expect(i, iExpect);
  });
}
