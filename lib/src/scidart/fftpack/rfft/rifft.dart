import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/fftpack/fft/ifft.dart';

/// Compute the one-dimensional inverse discrete Fourier Transform and return a Real output.
/// It is the inverse of [rfft] and follows `numpy.fft.irfft`.
/// - [x] an ArrayComplex with the non-negative frequency terms, as returned by [rfft]
/// - [n] length of the output. The default is 2 * (x.length - 1), which
///   recovers signals of even length. Pass the original length to recover a
///   signal of odd length. Missing terms are zero padded and extra terms are
///   ignored.
/// return An Array with IFFT output
///
/// # References
/// 1. "Fast Fourier Transform". https://rosettacode.org/wiki/Fast_Fourier_transform#C++. Retrieved 2019-07-23.
/// 2. "what is numpy fft rfft and numpy fft irfft and its equivalent code in matlab". https://stackoverflow.com/questions/45778504/what-is-numpy-fft-rfft-and-numpy-fft-irfft-and-its-equivalent-code-in-matlab. Retrieved 2019-07-23.
///
/// # Examples
/// ```dart
/// var X = ArrayComplex([
///   Complex(real: 4.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: -2.41421356),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: -0.41421356),
///   Complex(real: 0.0, imaginary: 0.0)
/// ]);
///
/// print(rifft(X));
///
/// /* output:
/// Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0])
/// */
/// ```
Array rifft(ArrayComplex x, {int? n}) {
  n ??= 2 * (x.length - 1);
  if (n < 1) {
    throw FormatException('invalid number of data points ($n) specified');
  }

  // non-negative frequency terms, zero padded or truncated to n ~/ 2 + 1
  var half = n ~/ 2 + 1;
  var xn = ArrayComplex.fixed(n);
  for (var k = 0; k < half; k++) {
    xn[k] = k < x.length ? x[k] : Complex();
  }

  // negative frequency terms are the complex conjugate of the positive ones
  // (Hermitian symmetry of the spectrum of a real signal)
  for (var k = half; k < n; k++) {
    xn[k] = complexConjugate(xn[n - k]);
  }

  // the imaginary part of the DC and Nyquist terms only adds an imaginary
  // component to the output, so the real part is the real signal
  var irfft = ifft(xn);
  return Array(irfft.map((c) => c.real).toList());
}
