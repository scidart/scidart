import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arraySinc', () {
    var n = Array([0.5 * pi, pi, (3 / 2) * pi, 2 * pi]);

    var sincn = arraySinc(n);

    print(sincn);

    var sincnExp = Array([-0.19765087, -0.04359863, 0.05306074, 0.03935584]);

    for (var i = 0; i < n.length; i++) {
      expect(truncate(sincn[i], 4), truncate(sincnExp[i], 4));
    }
  });
}
