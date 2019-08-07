import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/fftpack/fft/fft.dart';
import 'package:scidart/src/scidart/fftpack/fft/ifft.dart';

///  Compute the 1D convolution of 2 signals and return a ComplexArray
///  [input] : input signal ArrayComplex
///  [kernel] : kernel signal that will convolve with input ArrayComplex
///  References
///  ----------
///  .. [1] "difference between conv ifft fft when doing convolution". https://www.mathworks.com/matlabcentral/answers/38066-difference-between-conv-ifft-fft-when-doing-convolution. Retrieved 2019-07-25.
///  Examples
///  ----------
///  >>> var xi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).toComplexArray();
///  >>> var yi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).toComplexArray();
///  >>> var zi = convolutionComplex(xi, yi);
///  >>> print(zi);
///  ArrayComplex([
///      Complex(real: 1.0000000000000029, imaginary: -1.794120407794253e-14),
///      Complex(real: 1.9999999999999993, imaginary: -1.403321903126198e-14),
///      Complex(real: 2.9999999999999916, imaginary: -1.4921397450962105e-14),
///      Complex(real: 3.9999999999999907, imaginary: -9.947598300641402e-15),
///      Complex(real: 4.999999999999984, imaginary: -3.907985046680551e-15),
///      Complex(real: 5.999999999999984, imaginary: 3.552713678800501e-15),
///      Complex(real: 6.999999999999996, imaginary: 3.552713678800501e-16),
///      Complex(real: 8.0, imaginary: -7.460698725481052e-15),
///      Complex(real: 8.99999999999999, imaginary: 2.575717417130363e-15),
///      Complex(real: 9.999999999999991, imaginary: 8.764043402932554e-15),
///      Complex(real: 8.999999999999998, imaginary: 2.0161650127192842e-14),
///      Complex(real: 7.999999999999986, imaginary: -1.1013412404281553e-14),
///      Complex(real: 6.999999999999993, imaginary: 2.842170943040401e-15),
///      Complex(real: 6.0000000000000036, imaginary: 7.105427357601002e-15),
///      Complex(real: 4.999999999999984, imaginary: 3.907985046680551e-15),
///      Complex(real: 3.9999999999999987, imaginary: 1.4210854715202005e-15),
///      Complex(real: 3.0000000000000053, imaginary: -2.4868995751603505e-15),
///      Complex(real: 1.9999999999999982, imaginary: 1.687538997430238e-14),
///      Complex(real: 1.0000000000000082, imaginary: 8.704148513061228e-15)]);
ArrayComplex convolutionComplex(ArrayComplex input, ArrayComplex kernel) {
  // compute convolution using FFT
  var n = input.length + kernel.length; // n of final vector + 1
  var i = input.copy(); // copy of input
  i = arrayComplexPadStart(
      i, n - input.length); // padding with zeros the difference between lengths

  var k = kernel.copy(); // copy of kernel
  k = arrayComplexPadStart(k,
      n - kernel.length); // padding with zeros the difference between lengths

  var x = fft(i); // fft of i
  var y = fft(k); // fft of k

  var c = x * y; // arrayComplex multiplication

  // ifft of multiplication without last element because is close to zero.
  var d = arrayComplexTruncateLast(ifft(c));

  return d;
}
