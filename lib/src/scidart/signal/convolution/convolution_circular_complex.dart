import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/fftpack/fft/fft.dart';
import 'package:scidart/src/scidart/fftpack/fft/ifft.dart';
import 'package:scidart/src/scidart/signal/convolution/convolution_complex.dart';

///  Computes the circular convolution of the given complex vectors.
///  Each vector's length must be the same.
///  [input] : input signal
///  [kernel] : kernel periodic signal
///  [keepLength] : the output length is the same of the input, default is false
///  References
///  ----------
///  .. [1] "1d fast convolution". https://stackoverflow.com/questions/35474078/python-1d-array-circular-convolution. Retrieved 2019-07-25.
///  Examples
///  --------
///  >>> var xi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).toComplexArray();
///  >>> var yi = Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]).toComplexArray();
///  >>> convolutionCircularComplex(xi, yi);
///  ArrayComplex([
///  Complex(real: 1.0000000000000004, imaginary: -3.138230416273776e-14),
///  Complex(real: 1.9999999999999878, imaginary: -3.126388037344441e-14),
///  Complex(real: 2.999999999999988, imaginary: -2.0605739337042905e-14),
///  Complex(real: 3.999999999999982, imaginary: -2.5342690908776908e-14),
///  Complex(real: 4.999999999999975, imaginary: -1.4684549872375405e-14),
///  Complex(real: 5.999999999999973, imaginary: -9.947598300641402e-15),
///  Complex(real: 6.999999999999975, imaginary: -1.7053025658242404e-14),
///  Complex(real: 7.999999999999974, imaginary: -3.315866100213801e-15),
///  Complex(real: 8.999999999999964, imaginary: 5.684341886080802e-15),
///  Complex(real: 9.999999999999973, imaginary: 1.3737159558028604e-14),
///  Complex(real: 9.999999999999961, imaginary: 2.1789977229976407e-14),
///  Complex(real: 9.999999999999979, imaginary: 1.4210854715202005e-15),
///  Complex(real: 9.99999999999998, imaginary: 2.3803181647963357e-14),
///  Complex(real: 9.999999999999998, imaginary: 1.2730557349035129e-14),
///  Complex(real: 10.000000000000004, imaginary: 2.7889727564437797e-14),
///  Complex(real: 10.000000000000007, imaginary: 2.5224267119483555e-14),
///  Complex(real: 10.00000000000001, imaginary: 3.0908609005564356e-14),
///  Complex(real: 10.00000000000001, imaginary: 2.2026824808563106e-14),
///  Complex(real: 10.000000000000023, imaginary: 3.173757553061781e-14),
///  Complex(real: 10.000000000000037, imaginary: 3.0553337637684307e-14),
///  Complex(real: 9.000000000000057, imaginary: 2.4632148173016807e-14),
///  Complex(real: 8.000000000000021, imaginary: 9.000207986294602e-15),
///  Complex(real: 6.999999999999992, imaginary: -1.8000415972589204e-14),
///  Complex(real: 6.000000000000062, imaginary: -3.0790185216271006e-14),
///  Complex(real: 5.0000000000000036, imaginary: -2.1789977229976407e-14),
///  Complex(real: 3.9999999999999973, imaginary: -1.9421501444109406e-14),
///  Complex(real: 2.9999999999999933, imaginary: 3.884300288821881e-14),
///  Complex(real: 2.000000000000009, imaginary: 3.789561257387201e-15),
///  Complex(real: 1.0000000000000058, imaginary: -5.329070518200751e-16)])
ArrayComplex convolutionCircularComplex(ArrayComplex input, ArrayComplex kernel,
    {keepLength = false}) {
  if (keepLength) {
    var n = input.length;
    if (n != input.length || n != kernel.length) {
      throw FormatException('Mismatched lengths');
    }

    var x = fft(input);
    var y = fft(kernel);

    var c = x * y; // arrayComplex multiplication

    return ifft(c);
  } else {
    var ii = input.copy();
    var kk = kernel.copy();
    kk = arrayComplexConcat(kk, kk);
    return convolutionComplex(ii, kk);
  }
}
