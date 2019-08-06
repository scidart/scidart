import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/scidart.dart';

///  Calculate spectrum in dB scale
///  [x] : input signal
///  [fs] : sampling frequency
///  [window] : vector containing window samples (same length as x).
///           If not provided, then rectangular window is used by default.
///  [ref] : reference value used for dBFS scale. 32768 for int16 and 1 for float
///  Returns: List
///  [ [freq] : frequency vector
///    [s_db] ] : spectrum in dB scale
List dbfft(Array x, double fs, {String window, double ref = 32768}) {
  var N = x.length; // Length of input sequence

  var win;
  if (window == null) {
    win = ones(N);
  } else {
    win = getWindow(window, N);
  }
  x = x * win;

  // Calculate real FFT and frequency vector
  var sp = rfft(x);
  var freq = arrayDivisionToScalar(
      arange(stop: ((N / 2) + 1).toInt()), (N.toDouble() / fs));

  // Scale the magnitude of FFT by window and factor of 2,
  // because we are using half of FFT spectrum.
  var s_mag = arrayMultiplyToScalar(arrayComplexAbs(sp), 2 / arraySum(win));

  // Convert to dBFS
  var s_dbfs =
      arrayMultiplyToScalar(arrayLog10(arrayDivisionToScalar(s_mag, ref)), 20);

  return [freq, s_dbfs];
}
