import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('pad array with zeros at start', () {
    var a = Array([4.0, 4.0, 4.0]);
    var b = arrayPadStart(a, 2);

    var bExp = Array([0, 0, 4.0, 4.0, 4.0]);

    expect(b, bExp);
  });
}
