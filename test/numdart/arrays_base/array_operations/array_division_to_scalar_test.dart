import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('divideListToScalar', () {
    var list = Array([4.0, 8.0, 16.0]);

    var cList = arrayDivisionToScalar(list, 2);

    expect(cList.elementAt(0), 2.0);
    expect(cList.elementAt(1), 4.0);
    expect(cList.elementAt(2), 8.0);
  });
}
