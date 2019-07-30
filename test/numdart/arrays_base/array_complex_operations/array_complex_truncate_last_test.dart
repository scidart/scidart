import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('truncateLast', () {
    var list = ArrayComplex([
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0),
      Complex(real: 3.0, imaginary: 4.0)
    ]);

    var cList = arrayComplexTruncateLast(list);

    print(cList);

    expect(cList.length, 2.0);

    expect(cList.elementAt(0), Complex(real: 3.0, imaginary: 4.0));
    expect(cList.elementAt(1), Complex(real: 3.0, imaginary: 4.0));
  });
}
