import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/fftpack/fft/fft.dart';

/// Compute the one-dimensional discrete Fourier Transform for a Real input.
/// - [x] An Array with the input
/// - [n] : optional
/// Length of the transformed axis of the output.
/// If n is smaller than the length of the input, the input is cropped.
/// If it is larger, the input is padded with zeros.
/// If n is not given, the length of the input is used.
/// return An ArrayComplex with FFT output
///
/// # References
/// 1 "Fast Fourier Transform". https://rosettacode.org/wiki/Fast_Fourier_transform#C++. Retrieved 2019-07-23.
/// 2. "what is numpy fft rfft and numpy fft irfft and its equivalent code in matlab". https://stackoverflow.com/questions/45778504/what-is-numpy-fft-rfft-and-numpy-fft-irfft-and-its-equivalent-code-in-matlab. Retrieved 2019-07-23.
///
/// # Examples
/// ```dart
/// var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]);
///
/// print(rfft(x));
/// ```
ArrayComplex rfft(Array x, {n}) {
  var buffer = arrayToComplexArray(x);
  var afft = fft(buffer, n: n);
  return afft.getRangeArray(0, (afft.length / 2).floor() + 1); //  return afft;
}
