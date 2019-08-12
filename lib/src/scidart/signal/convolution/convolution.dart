import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/signal/convolution/convolution_complex.dart';

///  Compute the 1D convolution of 2 signals
///  [input] : input signal
///  [kernel] : kernel signal that will convolve with input
///  [fast] : optional parameter default false,
///           if true, compute convolution using FFT
///           if false (default), compute convolution using numerical definition
///  References
///  ----------
///  .. [1] "1d fast convolution". https://stackoverflow.com/questions/7237907/1d-fast-convolution-without-fft. Retrieved 2019-07-25.
///  Examples
///  --------
///  >>> var xi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
///  >>> var yi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
///  convolution(xi, yi);
///  Array([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0]);
Array convolution(Array input, Array kernel, {fast = false}) {
  if (fast) {
    // compute convolution using FFT
    var d = convolutionComplex(
        arrayToComplexArray(input), arrayToComplexArray(kernel));

    return arrayComplexAbs(d);
  } else {
    // compute convolution using numeric algorithm
    var result = Array.fixed(input.length + kernel.length - 1, initialValue: 0);
    for (var i = 0; i < input.length; i++) {
      for (var j = 0; j < kernel.length; j++) {
        result[i + j] += input[i] * kernel[j];
      }
    }

    return result;
  }
}
