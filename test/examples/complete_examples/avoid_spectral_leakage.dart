import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('avoid spectral leakage', () {
    // generate the signals for test
    // 1Hz sine wave with incomplete with result a spectral leakage
    // in the frequency domain
    var N = 20.0;
    var fs = 128.0;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);
    var f1 = 1.0; // 1Hz
    var sg = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));
    sg = sg.getRangeArray(0, sg.length - 201);
    sg = arrayConcat([sg, zeros(200)]);

    // reduce spectral leakage with a window function
    var sgWindowed = blackmanharris(sg.length) * sg;

    print(dbfft(sg, fs)); // fft of original signal
    print(dbfft(sgWindowed, fs)); // fft of windowed signal
  });
}
