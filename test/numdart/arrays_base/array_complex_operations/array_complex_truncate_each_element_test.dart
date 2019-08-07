import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arrayComplexTruncateEachElement', () {
    var n = ArrayComplex([
      Complex.ri(4.123456789, 4.123456789),
      Complex.ri(4.123456789, 4.123456789),
      Complex.ri(4.123456789, 4.123456789)
    ]);
    arrayComplexTruncateEachElement(n, 4);

    print(n);

    var nExp = ArrayComplex([
      Complex.ri(4.1235, 4.1235),
      Complex.ri(4.1235, 4.1235),
      Complex.ri(4.1235, 4.1235)
    ]);

    expect(n, nExp);
  });
}
