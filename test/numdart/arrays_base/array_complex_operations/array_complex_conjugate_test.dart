import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('conjugateArray', () {
    var list = ArrayComplex([
      Complex(real: 1.0, imaginary: 1.0),
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 3.0, imaginary: 3.0)
    ]);

    var cList = arrayComplexConjugate(list);

    print(cList);

    expect(cList.elementAt(0).real, 1.0);
    expect(cList.elementAt(0).imaginary, -1.0);

    expect(cList.elementAt(1).real, 2.0);
    expect(cList.elementAt(1).imaginary, -2.0);

    expect(cList.elementAt(2).real, 3.0);
    expect(cList.elementAt(2).imaginary, -3.0);
  });
}
