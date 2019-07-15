import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/signal/signal.dart';
import 'package:test/test.dart';

void main() {
  test('generate a nuttall window', () {
    var M = 10;
    var w = nuttall(M);

    print(w);

    var wExpect = Array([
      3.62800000e-04,
      1.78909987e-02,
      1.55596126e-01,
      5.29229800e-01,
      9.33220225e-01,
      9.33220225e-01,
      5.29229800e-01,
      1.55596126e-01,
      1.78909987e-02,
      3.62800000e-04
    ]);

    var fractionDigits = 7;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });

  test('generate a nuttall  asym', () {
    var M = 10;
    var w = nuttall(M, sym: false);

    print(w);

    var wExpect = Array([
      3.62800000e-04,
      1.33288369e-02,
      1.10515253e-01,
      3.95625913e-01,
      7.98258097e-01,
      1.00000000e+00,
      7.98258097e-01,
      3.95625913e-01,
      1.10515253e-01,
      1.33288369e-02
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });
}
