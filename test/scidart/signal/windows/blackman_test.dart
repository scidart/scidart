import 'package:scidart/scidart.dart';
import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('generate a blackman window', () {
    var M = 10;
    var w = blackman(M);

    print(w);

    var wExpect = Array([
      -1.38777878e-17,
      5.08696327e-02,
      2.58000502e-01,
      6.30000000e-01,
      9.51129866e-01,
      9.51129866e-01,
      6.30000000e-01,
      2.58000502e-01,
      5.08696327e-02,
      -1.38777878e-17
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });

  test('generate a blackman asym', () {
    var M = 10;
    var w = blackman(M, sym: false);

    print(w);

    var wExpect = Array([
      -1.38777878e-17,
      4.02128624e-02,
      2.00770143e-01,
      5.09787138e-01,
      8.49229857e-01,
      1.00000000e+00,
      8.49229857e-01,
      5.09787138e-01,
      2.00770143e-01,
      4.02128624e-02
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < w.length; i++) {
      expect(
          truncate(w[i], fractionDigits), truncate(wExpect[i], fractionDigits));
    }
  });
}
