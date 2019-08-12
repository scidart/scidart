import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('fftpack', () {
    // generate the signal for test
    // 1Hz sine wave
    var N = 50.0;
    var fs = 128.0;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);
    var f1 = 1.0; // 1Hz
    var sw = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

    // return the fft of the signal
    var swF = fft(arrayToComplexArray(sw));
    print(swF);

    // return the real fft, in other words,
    // only the components with of positive frequencies
    var swFr = rfft(sw);
    print(swFr);

    // return the frequency scale of FFT in Hz
    var swFScale = fftFreq(swF.length, d: 1 / fs);
    print(swFScale);

    // return only the real frequencies of FFT, useful to use with rFFT
    swFScale = fftFreq(swF.length, d: 1 / fs, realFrequenciesOnly: true);
    print(swFScale);

    print(ifft(swF)); // inverse FFT
    print(rifft(swFr)); // inverse FFT of a real FFT

    print(dbfft(sw, fs)); // Return the frequency and fft in DB scale
  });
}
