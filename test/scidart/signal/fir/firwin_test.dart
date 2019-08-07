import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('fir Low-pass from 0 to f', () {
    var numtaps = 3;
    var f = 0.1;
    var h = firwin(numtaps, Array([f]));

    var hExpec = Array([0.06799017, 0.86401967, 0.06799017]);

    print(h);

    expect(arrayTruncateEachElement(h, 4, returnNewArray: true),
        arrayTruncateEachElement(hExpec, 4, returnNewArray: true));
  });

  test('fir use a specific window function', () {
    var numtaps = 3;
    var f = 0.1;
    var h = firwin(numtaps, Array([f]), window: 'nuttall');

    var hExpec = Array([3.56607041e-04, 9.99286786e-01, 3.56607041e-04]);

    print(h);

    expect(arrayTruncateEachElement(h, 4, returnNewArray: true),
        arrayTruncateEachElement(hExpec, 4, returnNewArray: true));
  });

  test('fir high-pass (‘stop’ from 0 to f)', () {
    var numtaps = 3;
    var f = 0.1;
    var h = firwin(numtaps, Array([f]), pass_zero: false);

    var hExpec = Array([-0.00859313, 0.98281375, -0.00859313]);

    print(h);

    expect(arrayTruncateEachElement(h, 4, returnNewArray: true),
        arrayTruncateEachElement(hExpec, 4, returnNewArray: true));
  });

  test('fir band-pass', () {
    var numtaps = 3;
    var f = Array([0.1, 0.2]);
    var h = firwin(numtaps, f, pass_zero: false);

    var hExpec = Array([0.06301614, 0.88770441, 0.06301614]);

    print(h);

    expect(arrayTruncateEachElement(h, 4, returnNewArray: true),
        arrayTruncateEachElement(hExpec, 4, returnNewArray: true));
  });

  test('fir band-stop', () {
    var numtaps = 3;
    var f = Array([0.1, 0.2]);
    var h = firwin(numtaps, f);

    var hExpec = Array([-0.00801395, 1.0160279, -0.00801395]);

    print(h);

    expect(arrayTruncateEachElement(h, 4, returnNewArray: true),
        arrayTruncateEachElement(hExpec, 4, returnNewArray: true));
  });

  test('fir Multi-band (passbands are [0, f1], [f2, f3] and [f4, 1])', () {
    var numtaps = 3;
    var f = Array([0.1, 0.2, 0.3, 0.4]);
    var h = firwin(numtaps, f);

    var hExpec = Array([-0.01376344, 1.02752689, -0.01376344]);

    print(h);

    expect(arrayTruncateEachElement(h, 4, returnNewArray: true),
        arrayTruncateEachElement(hExpec, 4, returnNewArray: true));
  });

  test('fir Multi-band (passbands are [f1, f2] and [f3,f4])', () {
    var numtaps = 3;
    var f = Array([0.1, 0.2, 0.3, 0.4]);
    var h = firwin(numtaps, f, pass_zero: false);

    var hExpec = Array([0.04890915, 0.91284326, 0.04890915]);

    print(h);

    expect(arrayTruncateEachElement(h, 4, returnNewArray: true),
        arrayTruncateEachElement(hExpec, 4, returnNewArray: true));
  });
}
