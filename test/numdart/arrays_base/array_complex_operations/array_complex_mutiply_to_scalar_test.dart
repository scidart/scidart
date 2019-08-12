import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('multiplyArrayToScalar', () {
    var list = ArrayComplex([
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0)
    ]);

    var cList = arrayComplexMultiplyToScalar(list, 2);

    print(cList);

    expect(cList.elementAt(0).real, 4.0);
    expect(cList.elementAt(0).imaginary, 4.0);

    expect(cList.elementAt(1).real, 4.0);
    expect(cList.elementAt(1).imaginary, 4.0);

    expect(cList.elementAt(2).real, 4.0);
    expect(cList.elementAt(2).imaginary, 4.0);
  });
}
