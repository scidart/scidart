import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/signal/signal.dart';
import 'package:test/test.dart';

void main() {
  test('generate a flattop window', () {
    var M = 10;
    var w = flattop(M);

    print(w);

    var wExpect = Array([
      -4.21051000e-04,
      -2.01720315e-02,
      -7.01990421e-02,
      1.98210530e-01,
      8.62476344e-01,
      8.62476344e-01,
      1.98210530e-01,
      -7.01990421e-02,
      -2.01720315e-02,
      -4.21051000e-04
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });

  test('generate a flattop  asym', () {
    var M = 10;
    var w = flattop(M, sym: false);

    print(w);

    var wExpect = Array([
      -4.21051000e-04,
      -1.55972747e-02,
      -6.77142521e-02,
      5.45446482e-02,
      6.06872153e-01,
      1.00000000e+00,
      6.06872153e-01,
      5.45446482e-02,
      -6.77142521e-02,
      -1.55972747e-02
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });
}
