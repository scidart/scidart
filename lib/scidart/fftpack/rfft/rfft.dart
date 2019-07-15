// https://rosettacode.org/wiki/Fast_Fourier_transform#Java
import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fft/fft.dart';

ArrayComplex rfft(Array x) {
  var buffer = x.toComplexArray();
  return fft(buffer);
}