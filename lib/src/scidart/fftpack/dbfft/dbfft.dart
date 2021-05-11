import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/scidart.dart';

/// Calculate spectrum in dB scale
/// - [x] : input signal
/// - [fs] : sampling frequency
/// - [window] : vector containing window samples (same length as x).
/// If not provided, then rectangular window is used by default.
/// - [ref] : reference value used for dBFS scale. 32768 for int16 and 1 for float
///
/// # Returns:
/// List
/// - [freq] : frequency vector
/// - [s_db] : spectrum in dB scale
///
/// # References
/// 1. "fft to spectrum in decibel". https://dsp.stackexchange.com/questions/32076/fft-to-spectrum-in-decibel. Retrieved 2019-08-07.
/// 2. "fft to decibel gist". https://gist.github.com/ganwell/3772157. Retrieved 2019-08-07.
/// 3. "from amplitude or fft to db". https://stackoverflow.com/questions/53761077/from-amplitude-or-fft-to-db. Retrieved 2019-08-07.
/// 4. "How do I convert FFT output values to decibels?". https://groups.google.com/forum/#!topic/comp.dsp/cZsS1ftN5oI. Retrieved 2019-08-07.
/// 5. "matplot lib source code". https://github.com/matplotlib/matplotlib/blob/0f54425419b4f91781d2de47b5c315bbfa0540c3/lib/matplotlib/mlab.py#L429. Retrieved 2019-08-07.
/// 6. "matplot magnitude spectrum". https://matplotlib.org/3.1.1/_modules/matplotlib/axes/_axes.html#Axes.magnitude_spectrum. Retrieved 2019-08-07.
///
/// # Examples
/// ```dart
/// var fs = 10.0;
/// sg1 = Array([0, 1, 2, 3, 4]);
///
/// print(dbfft(sg1, fs));
/// ```
List dbfft(Array x, double fs, {String? window, double? ref}) {
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

  ref ??= arrayMax(s_mag);

  // Convert to dBFS
  var s_dbfs =
      arrayMultiplyToScalar(arrayLog10(arrayDivisionToScalar(s_mag, ref)), 20);

  return [freq, s_dbfs];
}
