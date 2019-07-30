import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('truncateEachElement', () {
    var a = Array2d([
      Array([2.123456789, 2.123456789, 2.123456789]),
      Array([2.123456789, 2.123456789, 2.123456789]),
      Array([2.123456789, 2.123456789, 2.123456789])
    ]);

    array2dTruncateEachElement(a, 4);

    print(a);

    var aExpec = Array2d([
      Array([2.1235, 2.1235, 2.1235]),
      Array([2.1235, 2.1235, 2.1235]),
      Array([2.1235, 2.1235, 2.1235])
    ]);

    expect(a, aExpec);
  });
}
