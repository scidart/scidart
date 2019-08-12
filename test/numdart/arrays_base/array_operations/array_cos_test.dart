import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('cosArray', () {
    var n = Array([0.5 * pi, pi, (3 / 2) * pi, 2 * pi]);

    var cosn = arrayCos(n);

    print(n);

    print(cosn);

    var cosnExp = [0.0, -1.0, 0.0, 1.0];

    for (var i = 0; i < n.length; i++) {
      expect(truncate(cosn[i], 4), truncate(cosnExp[i], 4));
    }
  });
}
