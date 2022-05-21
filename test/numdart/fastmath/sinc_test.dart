import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('sinc', () {
    var a = sinc(pi / 2);

    var aExpec = -0.19765087;

    print(a);

    expect(truncate(a, 4), truncate(aExpec, 4));
  });
}
