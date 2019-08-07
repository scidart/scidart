import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('multiplyArrayToScalar', () {
    var list = Array([4.0, 4.0, 4.0]);

    var cList = arrayMultiplyToScalar(list, 2);

    expect(cList.elementAt(0), 8.0);
    expect(cList.elementAt(1), 8.0);
    expect(cList.elementAt(2), 8.0);
  });
}
