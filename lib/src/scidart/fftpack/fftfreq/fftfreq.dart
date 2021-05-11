import 'package:scidart/src/numdart/numdart.dart';

/// Return the Discrete Fourier Transform sample frequencies.
/// The returned float array `f` contains the frequency bin centers in cycles
/// per unit of the sample spacing (with zero at the start).  For instance, if
/// the sample spacing is in seconds, then the frequency unit is cycles/second.
/// Given a window length `n` and a sample spacing `d`::
///   f = [0, 1, ...,   n/2-1,     -n/2, ..., -1] / (d*n)   if n is even
///   f = [0, 1, ..., (n-1)/2, -(n-1)/2, ..., -1] / (d*n)   if n is odd
///
/// # Parameters
/// - [n] : int
/// Window length.
/// - [d] : double, optional
/// Sample spacing (inverse of the sampling rate (1/FS), Fs if called sampling frequency too)). Defaults to 1.
/// - [realFrequenciesOnly] : bool, optional
/// if true, return only real frequencies of the FFT
///
/// # Returns
/// - f : Array
/// Array of length `n` containing the sample frequencies.
///
/// # References
/// 1. "Numpy FFT helper". https://github.com/numpy/numpy/blob/master/numpy/fft/helper.py. Retrieved 2019-07-25.
/// 2. "How to scale the frequency axis after performing fft?". https://www.mathworks.com/matlabcentral/answers/303075-how-to-scale-the-frequency-axis-after-performing-fft. Retrieved 2019-07-25.
/// 3. "Fast Fourier Transform in matplotlib". https://plot.ly/matplotlib/fft/. Retrieved 2019-07-25.
/// 4. "Fourier Transforms (scipy.fftpack)". https://docs.scipy.org/doc/scipy/reference/tutorial/fftpack.html. Retrieved 2019-07-25.
///
/// # Examples
/// ```dart
/// var signal = Array([-2, 8, 6, 4, 1, 0, 3, 5]);
/// var fourier = rfft(signal).abs();
/// var n = signal.length;
/// var timeStep = 0.1;
/// var freq = fftFreq(n, d: timeStep);
///
/// print(fourier);
/// print(freq);
///
/// /* output:
/// Array([25.0, 8.632190835805323, 10.04987562112089, 9.56479384901936, 9.0, 9.56479384901936, 10.04987562112089, 8.632190835805325])
/// Array([0.0, 1.25, 2.5, 3.75, -5.0, -3.75, -2.5, -1.25])
/// */
/// ```
Array fftFreq(int n, {double d = 1.0, bool realFrequenciesOnly = false}) {
  var val = 1.0 / (n * d);
  var results = Array.empty();
  var N = (n - 1) ~/ 2 + 1;
  var p1 = arange(start: 0, stop: N);
  results = arrayConcat([results, p1]);
  if (!realFrequenciesOnly) {
    var p2 = arange(start: -(n ~/ 2), stop: 0);
    results = arrayConcat([results, p2]);
  }
  return arrayMultiplyToScalar(results, val);
}
