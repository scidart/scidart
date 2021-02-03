import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('truncate a number', () {
    var n = truncate(1.4747474747474747, 3);
    expect(n, 1.475);
  });

  test('even double number', () {
    expect(isEvenDouble(1.1141, 3), true);
    expect(isEvenDouble(1.2212, 3), false);
  });

  test('odd double number', () {
    expect(isOddDouble(1.4474, 3), true);
    expect(isOddDouble(1.3343, 3), false);
  });
}
