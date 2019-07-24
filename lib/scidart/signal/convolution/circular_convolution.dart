import 'package:scidart/numdart/array/arrayComplex.dart';
import 'package:scidart/scidart/fftpack/fft/fft.dart';
import 'package:scidart/scidart/fftpack/fft/ifft.dart';

///  Computes the circular convolution of the given complex vectors.
///  Each vector's length must be the same.
///  [xi] : vector x
///  [yi] : vector yi
ArrayComplex circularConvolution(ArrayComplex xi, ArrayComplex yi) {
  int n = xi.length;
  if (n != xi.length || n != yi.length) {
    throw FormatException("Mismatched lengths");
  }

  var x = fft(xi);
  var y = fft(yi);

  var c = x * y; // arrayComplex multiplication

  return ifft(c);
}
