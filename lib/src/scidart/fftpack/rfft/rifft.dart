import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/fftpack/fft/ifft.dart';

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
Array rifft(ArrayComplex x) {
  var s;

  // estimate if final lengh is even or odd
//  var even = (x.length * 2) % 2 == 0 ? true: false;
  var even = false;

  if (even) {
//    n = 2 * (length(x) - 1 );
    s = 0;
  } else {
//    n = 2 * (length(x) - 1 )+1;
    s = 1;
  }

  // create a empty array
  var xn = ArrayComplex.empty();

  // concatenate the input x
  xn = arrayComplexConcat(xn, x);
  // array a zero
  xn.add(Complex());

  // concatenate the conjugate complex
  xn = arrayComplexConcat(xn, arrayComplexConjugate(
      x.getRangeArray(s, x.length, step: 1, reverse: true)));

  var irfft = ifft(xn);

  // absulute value of the list
  var xReal = arrayComplexAbs(irfft);

  return xReal;
}