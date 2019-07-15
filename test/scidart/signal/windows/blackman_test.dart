import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/signal/signal.dart';
import 'package:test/test.dart';

void main() {
  test('generate a blackman window', () {
    var M = 10;
    var w = blackman(M);

    print(w);

    var wExpect = Array([
      0.0,
      0.11697778,
      0.41317591,
      0.75,
      0.96984631,
      0.96984631,
      0.75,
      0.41317591,
      0.11697778,
      0.0
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });

  test('generate a hann blackman asym', () {
    var M = 10;
    var w = blackman(M, sym: false);

    print(w);

    var wExpect = Array([
      0.0,
      0.0954915,
      0.3454915,
      0.6545085,
      0.9045085,
      1.0,
      0.9045085,
      0.6545085,
      0.3454915,
      0.0954915
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });
}
