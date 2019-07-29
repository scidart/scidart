import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('expFast', () {
    var a = expFast(1);
    var aExpec = 2.718281828459045;

    print(a);

    expect(a, aExpec);
  });
}
