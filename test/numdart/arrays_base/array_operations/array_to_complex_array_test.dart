import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('toComplexList', () {
    var list = Array([1.0, 2.0, 3.0]);

    var cList = arrayToComplexArray(list);

    expect(cList.elementAt(0).real, 1.0);
    expect(cList.elementAt(0).imaginary, 0.0);

    expect(cList.elementAt(1).real, 2.0);
    expect(cList.elementAt(1).imaginary, 0.0);

    expect(cList.elementAt(2).real, 3.0);
    expect(cList.elementAt(2).imaginary, 0.0);
  });
}
