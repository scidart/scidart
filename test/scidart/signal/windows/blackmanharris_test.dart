import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/signal/signal.dart';
import 'package:test/test.dart';

void main() {
  test('generate a blackmanharris window', () {
    var M = 10;
    var w = blackmanharris(M);

    print(w);

    var wExpect = Array([
      6.00000000e-05,
      1.50711734e-02,
      1.47039558e-01,
      5.20575000e-01,
      9.31659269e-01,
      9.31659269e-01,
      5.20575000e-01,
      1.47039558e-01,
      1.50711734e-02,
      6.00000000e-05
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });

  test('generate a blackmanharris  asym', () {
    var M = 10;
    var w = blackmanharris(M, sym: false);

    print(w);

    var wExpect = Array([
      6.00000000e-05,
      1.09823313e-02,
      1.03011489e-01,
      3.85892669e-01,
      7.93833511e-01,
      1.00000000e+00,
      7.93833511e-01,
      3.85892669e-01,
      1.03011489e-01,
      1.09823313e-02
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });
}
