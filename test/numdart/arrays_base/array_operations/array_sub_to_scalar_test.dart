import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arraySubToScalar', () {
    var list = Array([4.0, 4.0, 4.0]);

    var cList = arraySubToScalar(list, 2);

    expect(cList.elementAt(0), 2.0);
    expect(cList.elementAt(1), 2.0);
    expect(cList.elementAt(2), 2.0);
  });
}
