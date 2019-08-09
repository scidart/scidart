import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('fftpack', () {
    // generate the signals for test
    // 1Hz sine wave
    var N = 50.0;
    var fs = 128.0;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);
    var f1 = 1.0; // 1Hz
    var sw = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

    var swF = fft(arrayToComplexArray(sw)); // return the fft of the signal
    print(swF);

    var swFr = rfft(
        sw); // return the real fft, in other words, only the components with of positive frequencies
    print(swFr);

    var swFScale = fftFreq(swF.length,
        d: 1 / fs); // return the frequency scale of FFT in Hz
    print(swFScale);

    print(ifft(swF)); // inverse FFT
    print(rifft(swFr)); // inverse FFT of a real FFT

    print(dbfft(sw, fs)); // Return the frequency and fft in DB scale
  });
}
