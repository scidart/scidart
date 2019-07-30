import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('absList', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0)
    ]);

    var cList = arrayComplexAbs(list);

    print(cList);

    expect(cList.elementAt(0), 5.0);
    expect(cList.elementAt(1), 5.0);
    expect(cList.elementAt(2), 5.0);
  });
}
