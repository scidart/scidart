import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('copySign', () {
    var a = copySign(5, -20);
    var aExpec = -5;

    print(a);

    expect(a, aExpec);
  });
}
