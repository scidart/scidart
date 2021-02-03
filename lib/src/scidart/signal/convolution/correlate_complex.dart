import 'package:scidart/scidart.dart';

import '../../../../numdart.dart';

/// Compute the 1D cross-correlation of 2 complex signals
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
/// var xi = ArrayComplex([
///   Complex(real: 1, imaginary: 1),
///   Complex(real: 0, imaginary: 0),
///   Complex(real: 0, imaginary: 0),
///   Complex(real: 0, imaginary: 0),
///   Complex(real: 0, imaginary: 0)
/// ]);
/// var yi = ArrayComplex([
///   Complex(real: 0, imaginary: 0),
///   Complex(real: 0, imaginary: 0),
///   Complex(real: 0, imaginary: 0),
///   Complex(real: 0, imaginary: 0),
///   Complex(real: 1, imaginary: 1)
/// ]);
///
/// print(correlateComplex(xi, yi));
///
/// /* output:
/// ArrayComplex([
///   Complex(real: 2.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 0.0, imaginary: 0.0)]
/// )
/// */
/// ```
ArrayComplex correlateComplex(ArrayComplex input, ArrayComplex kernel) {
  return convolutionComplex(
      input, arrayComplexConjugate(arrayComplexReverse(kernel)));
}
