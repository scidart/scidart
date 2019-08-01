import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('sinArray', () {
    var n = Array([0.5 * pi, pi, (3 / 2) * pi, 2 * pi]);

    var sinn = arraySin(n);

    print(n);

    print(sinn);

    var sinnExp = [1.0, 0.0, -1.0, 0.0];

    for (var i = 0; i < n.length; i++) {
      expect(truncate(sinn[i], 4), truncate(sinnExp[i], 4));
    }
  });
}
