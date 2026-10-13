import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('atan2Fast', () {
    var a = atan2Fast(5, 5); // arctan(5/5) = arctg(1)
    var aExpec = 45 * pi / 180; // arctan of 1 is 45 degree

    print(a);

    expect(a, aExpec);
  });
}
