import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';

void main() {
  // generate the signals for test
  // 1Hz sine wave
  var N = 50.0;
  var fs = 128.0;
  var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);
  var f1 = 1.0; // 1Hz
  var sg1 = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

  var fEstimated = freqFromFft(sg1, fs);

  print('The original and estimated frequency need be very close each other');
  print('Original frequency: $f1');
  print('Estimated frequency: $fEstimated');
}

double freqFromFft(Array sig, double fs) {
  // Estimate frequency from peak of FFT

  // Compute Fourier transform of windowed signal
  // Avoid spectral leakage: https://en.wikipedia.org/wiki/Spectral_leakage
  var windowed = sig * blackmanharris(sig.length);
  var f = rfft(windowed);

  var fAbs = arrayComplexAbs(f);

  // Find the peak and interpolate to get a more accurate peak
  var i = arrayArgMax(fAbs); // Just use this for less-accurate, naive version

  // Parabolic approximation is necessary to get the exactly frequency of a discrete signal
  // since the frequency can be in some point between the samples.
  var true_i = parabolic(arrayLog(fAbs), i)[0];

  // Convert to equivalent frequency
  return fs * true_i / windowed.length;
}
