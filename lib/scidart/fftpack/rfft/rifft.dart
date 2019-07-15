import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fft/ifft.dart';

Array rifft(ArrayComplex X) {
  var x = ifft(X);

  // absulute value of the list
  var xReal = x.absArray();

  return xReal;
}