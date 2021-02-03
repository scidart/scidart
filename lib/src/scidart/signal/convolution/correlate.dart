import '../../../../numdart.dart';
import 'convolution.dart';

/// Compute the 1D cross-correlation of 2 signals
/// - [input] : input signal
/// - [kernel] : kernel signal that will convolve with input
/// - [fast] : optional parameter default false,
/// if true, compute convolution using FFT
/// if false (default), compute convolution using numerical definition
///
/// # References
/// 1. "enhancement: add cross-correlation". https://github.com/scidart/scidart/issues/20. Retrieved 2021-02-01.
/// 2. "Scipy correlate". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.correlate.html. Retrieved 2021-02-03.
/// 3. "Cross-correlation". https://en.wikipedia.org/wiki/Cross-correlation. Retrieved 2021-02-03.
///
/// # Examples
/// ```dart
/// var xi = Array([1, 0, 0, 0, 0]);
/// var yi = Array([0, 0, 0, 0, 1]);
///
/// print(correlate(xi, yi));
///
/// /* output:
/// Array([1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
/// */
/// ```
Array correlate(Array input, Array kernel, {fast = false}) {
  return convolution(input, arrayReverse(kernel), fast: fast);
}
