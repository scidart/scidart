import 'package:scidart/scidart.dart';
import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('generate a hamming window', () {
    var M = 10;
    var w = hamming(M);

    print(w);

    var wExpect = Array([
      0.08,
      0.18761956,
      0.46012184,
      0.77,
      0.97225861,
      0.97225861,
      0.77,
      0.46012184,
      0.18761956,
      0.08
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });

  test('generate a hamming  asym', () {
    var M = 10;
    var w = hamming(M, sym: false);

    print(w);

    var wExpect = Array([
      0.08,
      0.16785218,
      0.39785218,
      0.68214782,
      0.91214782,
      1.0,
      0.91214782,
      0.68214782,
      0.39785218,
      0.16785218
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });
}
