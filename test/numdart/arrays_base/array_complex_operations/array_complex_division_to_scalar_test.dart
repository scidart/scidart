import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('divideArrayToScalar', () {
    var list = ArrayComplex([
      Complex(real: 4.0, imaginary: 4.0),
      Complex(real: 8.0, imaginary: 8.0),
      Complex(real: 16.0, imaginary: 16.0)
    ]);

    var cList = arrayComplexDivisionToScalar(list, 2);

    print(cList);

    expect(cList.elementAt(0).real, 2.0);
    expect(cList.elementAt(0).imaginary, 2.0);

    expect(cList.elementAt(1).real, 4.0);
    expect(cList.elementAt(1).imaginary, 4.0);

    expect(cList.elementAt(2).real, 8.0);
    expect(cList.elementAt(2).imaginary, 8.0);
  });
}
