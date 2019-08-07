import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('random array', () {
    var x = randomArrayComplex(20);
    print(x);
    var xExpec = 20;

    expect(x.length, xExpec);
  });
}
