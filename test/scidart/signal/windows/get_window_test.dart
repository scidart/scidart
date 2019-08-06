import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/signal/signal.dart';
import 'package:test/test.dart';

void main() {
  test('get a kaiser window', () {
    var w = getWindow(['kaiser', 4.0], 9);

    var wExpec = Array([
      0.08848053,
      0.32578323,
      0.63343178,
      0.89640418,
      1.0,
      0.89640418,
      0.63343178,
      0.32578323,
      0.08848053
    ]);

    expect(arrayTruncateEachElement(w, 5), arrayTruncateEachElement(wExpec, 5));
  });

  test('get a kaiser window implicit', () {
    var w = getWindow(4.0, 9);

    var wExpec = Array([
      0.08848053,
      0.32578323,
      0.63343178,
      0.89640418,
      1.0,
      0.89640418,
      0.63343178,
      0.32578323,
      0.08848053
    ]);

    expect(arrayTruncateEachElement(w, 5), arrayTruncateEachElement(wExpec, 5));
  });

  test('get a blackman window', () {
    var w = getWindow('black', 10);

    var wExpec = Array([
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

    expect(arrayTruncateEachElement(w, 5), arrayTruncateEachElement(wExpec, 5));
  });
}
