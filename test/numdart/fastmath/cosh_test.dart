import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('cosh', () {
    var a = cosh(pi / 2);

    var aExpec = 2.5091784786580567;

    print(a);

    expect(a, aExpec);
  });
}
