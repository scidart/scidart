import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fft/fft.dart';

// https://rosettacode.org/wiki/Fast_Fourier_transform#C++
ArrayComplex ifft(ArrayComplex X) {
  // conjugate the complex numbers
  var XConj = X.conjugateArray();

  // forward fft
  var xImag = fft(XConj);

  // conjugate the complex numbers again
  xImag = xImag.conjugateArray();

  // scale the numbers
  xImag = xImag.divideArrayToScalar(xImag.length);

  return xImag;
}