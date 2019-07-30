import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fft/ifft.dart';

///  Compute the one-dimensional inverse discrete Fourier Transform and return a Real output.
///  [X] A ArrayComplex with the input
///  return A Array with IFFT output
///  References
///  ----------
///  .. [1] "Fast Fourier Transform". // https://rosettacode.org/wiki/Fast_Fourier_transform#C++. Retrieved 2019-07-23.
///  Examples
///  --------
///  >>> var X = ArrayComplex([
///  >>>    Complex(real: 4.0, imaginary: 0.0),
///  >>>    Complex(real: 1.0, imaginary: -2.41421356),
///  >>>    Complex(real: 0.0, imaginary: 0.0),
///  >>>    Complex(real: 1.0, imaginary: -0.41421356),
///  >>>    Complex(real: 0.0, imaginary: 0.0),
///  >>>    Complex(real: 1.0, imaginary: 0.41421356),
///  >>>    Complex(real: 0.0, imaginary: 0.0),
///  >>>    Complex(real: 1.0, imaginary: 2.41421356)
///  >>> ]);
///  >>> rifft(X);
///  >>> Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0])
Array rifft(ArrayComplex X) {
  var x = ifft(X);

  // absulute value of the list
  var xReal = arrayComplexAbs(x);

  return xReal;
}