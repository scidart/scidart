import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('atanFast', () {
    var a = atanFast(1); // arctan(1)
    var aExpec = 45 * pi / 180; // arctan(1) = 45 degree

    print(a);

    expect(a, aExpec);
  });
}
