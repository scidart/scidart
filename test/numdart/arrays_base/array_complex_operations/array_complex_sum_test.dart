import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create and sum arrays', () {
    var list = ArrayComplex([
      Complex(real: 1, imaginary: 1),
      Complex(real: 1, imaginary: 1),
      Complex(real: 1, imaginary: 1)
    ]);
    var list2 = ArrayComplex([
      Complex(real: 1, imaginary: 1),
      Complex(real: 1, imaginary: 1),
      Complex(real: 1, imaginary: 1)
    ]);

    var cList = arrayComplexSum(list, list2);

    print(cList);

    expect(cList.elementAt(0), Complex(real: 2, imaginary: 2));
    expect(cList.elementAt(1), Complex(real: 2, imaginary: 2));
    expect(cList.elementAt(2), Complex(real: 2, imaginary: 2));
  });
}
