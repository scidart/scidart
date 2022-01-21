import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/fftpack/fft/ifft.dart';

/// Compute the one-dimensional inverse discrete Fourier Transform and return a Real output.
/// - [x] an ArrayComplex with the input
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
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: 0.41421356),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: 2.41421356)
/// ]);
///
/// print(rifft(X));
///
/// /* output:
/// Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0])
/// */
/// ```
Array rifft(ArrayComplex x) {
  var s, e;

  // determine if even or odd to reconstruct the FFT signal
  var even = x.length % 2 == 0;

  // create an empty array
  var xn = ArrayComplex.empty();

  // concatenate the input x
  xn = arrayComplexConcat(xn, x);

  if (even) {
    // if even, reversed conjugate complex start at index 1 and go until end
    s = 1;
    e = x.length;
  } else {
    // if odd, reversed conjugate complex start at index 1 and go until Last - 1
    s = 1;
    e = x.length - 1;
  }

  // concatenate the current array with your own reverse and the conjugate complex
  // fft symmetry estimation
  xn = arrayComplexConcat(
      xn, arrayComplexConjugate(x.getRangeArray(s, e, step: 1, reverse: true)));

  // calculate the IFFT
  var irfft = ifft(xn);

  // absulute value of the list
  var xReal = arrayComplexAbs(irfft);

  return xReal;
}
