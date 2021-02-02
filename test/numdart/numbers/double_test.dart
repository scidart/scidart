import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('truncate a number', () {
    var n = truncate(1.4747474747474747, 3);
    expect(n, 1.475);
  });
}
