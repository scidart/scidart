import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fft/fft.dart';

// https://rosettacode.org/wiki/Fast_Fourier_transform#C++
ArrayComplex ifft(ArrayComplex X) {
  // conjugate the complex numbers
  var XConj = X.conjugate();

  // forward fft
  var xImag = fft(XConj);

  // conjugate the complex numbers again
  xImag = xImag.conjugate();

  // scale the numbers
  xImag = xImag.divisionToScalar(xImag.length);

  return xImag;
}