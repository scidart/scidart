import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arrayAddToScalar', () {
    var list = Array([4.0, 4.0, 4.0]);

    var cList = arrayAddToScalar(list, 2);

    expect(cList.elementAt(0), 6.0);
    expect(cList.elementAt(1), 6.0);
    expect(cList.elementAt(2), 6.0);
  });
}
