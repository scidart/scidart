import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('cos', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0)
    ]);

    var cList = arrayComplexCos(list);

    print(cList);

    expect(cList.elementAt(0),
        Complex(real: -27.034945603074224, imaginary: -3.8511533348117775));
    expect(cList.elementAt(1),
        Complex(real: -27.034945603074224, imaginary: -3.8511533348117775));
    expect(cList.elementAt(2),
        Complex(real: -27.034945603074224, imaginary: -3.8511533348117775));
  });
}
