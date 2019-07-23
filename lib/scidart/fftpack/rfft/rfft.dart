import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fft/fft.dart';

///  Compute the one-dimensional discrete Fourier Transform for a Real input.
///  [x] A Array with the input
///  return A ArrayComplex with FFT output
///  References
///  ----------
///  .. [1] "Fast Fourier Transform". // https://rosettacode.org/wiki/Fast_Fourier_transform#C++. Retrieved 2019-07-23.
///  Examples
///  --------
///  >>> var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]);
///  >>> rfft(x);
///  >>> ArrayComplex([
///  >>>   Complex(real: 4.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: -2.41421356),
///  >>>   Complex(real: 0.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: -0.41421356),
///  >>>   Complex(real: 0.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: 0.41421356),
///  >>>   Complex(real: 0.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: 2.41421356)
///  >>> ]);
ArrayComplex rfft(Array x) {
  var buffer = x.toComplexArray();
  return fft(buffer);
}