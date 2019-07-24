import 'dart:math';
import 'dart:math' as math;

import 'package:scidart/numdart/array/array.dart';
import 'package:scidart/numdart/array/arrayComplex.dart';
import 'package:scidart/numdart/numbers/complex.dart';
import 'package:scidart/numdart/numbers/int.dart';
import 'package:scidart/scidart/signal/convolution/circular_convolution.dart';

///  Compute the one-dimensional discrete Fourier Transform.
///  [buffer] : A ArrayComplex with the input
///  [n] : optional
///        Length of the transformed axis of the output.
///        If n is smaller than the length of the input, the input is cropped.
///        If it is larger, the input is padded with zeros.
///        If n is not given, the length of the input is used.
///  return A ArrayComplex with FFT output
///  References
///  ----------
///  .. [1] "Fast Fourier Transform". https://rosettacode.org/wiki/Fast_Fourier_transform#C++. Retrieved 2019-07-23.
///  .. [2] "Free small FFT in multiple languages". https://www.nayuki.io/page/free-small-fft-in-multiple-languages. Retrieved 2019-07-23.
///  .. [3] "looking for fft1d arbitrary length code". https://stackoverflow.com/questions/34655959/looking-for-fft1d-arbitrary-length-code. Retrieved 2019-07-23.
///  .. [4] "Chirp_Z-transform Bluestein". https://en.wikipedia.org/wiki/Chirp_Z-transform#Bluestein.27s_algorithm. Retrieved 2019-07-24.
///  .. [4] "numpy.fft.fft". https://docs.scipy.org/doc/numpy/reference/generated/numpy.fft.fft.html#numpy.fft.fft. Retrieved 2019-07-24.
///  Examples
///  --------
///  >>> var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]).toComplexArray();
///  >>> fft(x);
///  >>> ArrayComplex([
///  >>>   Complex(real: 4.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: -2.41421356),
///  >>>   Complex(real: 0.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: -0.41421356),
///  >>>   Complex(real: 0.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: 0.41421356),
///  >>>   Complex(real: 0.0, imaginary: 0.0),
///  >>>   Complex(real: 1.0, imaginary: 2.41421356)
///  >>> ]);
ArrayComplex fft(ArrayComplex x, {n}) {
  var buffer;
  if (n == null || n == x.length) {
    n = x.length;
    buffer = x.copy();
  } else if (n < x.length) {
    buffer = ArrayComplex.empty();
    for (var i = 0; i < n; i++) {
      buffer.add(x[i]);
    }
  } else if (n > x.length) {
    buffer = ArrayComplex.empty();
    var pad = n - x.length;
    while (pad > 0) {
      buffer.add(Complex());
      pad--;
    }
    buffer.concat(x);
  }

  if (buffer.isEmpty) {
    return ArrayComplex.empty();
  }
  else if ((n & (n - 1)) == 0) { // Is power of 2
    return _transformRadix2(buffer);
  }
  else { // More complicated algorithm for arbitrary sizes
    return _transformBluestein(buffer);
  }


//  var buffer = ArrayComplex.empty();
//  if (x.length % 2 != 0) {
//    var i = x.length + 1;
//    while (i % 2 != 0) {
//      i++;
//    }
//
//    buffer = ArrayComplex.empty();
//
//    var pad = i - x.length - 1;
//    while (pad >= 0) {
//      buffer.add(Complex());
//      pad--;
//    }
//
//    buffer.append(x);
//  } else {
//    buffer = ArrayComplex(x);
//  }

//  buffer = ArrayComplex(x);
//
//  return buffer;
}

///  Computes the discrete Fourier transform (DFT) of the given complex vector, storing the result back into the vector.
///  The vector's length must be a power of 2. Uses the Cooley-Tukey decimation-in-time radix-2 algorithm.
ArrayComplex _transformRadix2(ArrayComplex x) {
  var buffer = x.copy();
  int bits = log(buffer.length) ~/ log(2);
  for (int j = 1; j < buffer.length / 2; j++) {
    int swapPos = bitReverse(j, bits);
    Complex temp = buffer[j];
    buffer[j] = buffer[swapPos];
    buffer[swapPos] = temp;
  }

  for (int N = 2; N <= buffer.length; N <<= 1) {
    for (int i = 0; i < buffer.length; i += N) {
      for (int k = 0; k < N / 2; k++) {
        int evenIndex = i + k;
        int oddIndex = (i + k + (N / 2)).toInt();
        Complex even = buffer[evenIndex];
        Complex odd = buffer[oddIndex];

        double term = (-2 * pi * k) / N;
        Complex exp = Complex(real: cos(term), imaginary: sin(term)) * odd;

        buffer[evenIndex] = even + exp;
        buffer[oddIndex] = even - exp;
      }
    }
  }

  return buffer;
}

///  Computes the discrete Fourier transform (DFT) of the given complex vector, storing the result back into the vector.
///  The vector can have any length. This requires the convolution function, which in turn requires the radix-2 FFT function.
///  Uses Bluestein's chirp z-transform algorithm.
ArrayComplex _transformBluestein(ArrayComplex buffer) {
  var n = buffer.length;
  // Find a power-of-2 convolution length m such that m >= n * 2 + 1
  if (n >= 0x20000000) {
    throw FormatException("Array too large");
  }

  int m = highestOneBit(n) * 4;

  // Trignometric tables
  Array cosTable = Array.fixed(n);
  Array sinTable = Array.fixed(n);
  for (int i = 0; i < n; i++) {
    int j = (i.toDouble() * i % (n * 2))
        .toInt(); // This is more accurate than j = i * i
    cosTable[i] = math.cos(math.pi * j / n);
    sinTable[i] = math.sin(math.pi * j / n);
  }

  // Temporary vectors and preprocessing
  ArrayComplex a = ArrayComplex.fixed(m, initialValue: Complex());
  for (int i = 0; i < n; i++) {
    var areal = buffer[i].real * cosTable[i] +
        buffer[i].imaginary * sinTable[i];
    var aimag = -buffer[i].real * sinTable[i] +
        buffer[i].imaginary * cosTable[i];
    a[i] = Complex(real: areal, imaginary: aimag);
  }

  ArrayComplex b = ArrayComplex.fixed(m, initialValue: Complex());
  b[0] = Complex(real: cosTable[0], imaginary: sinTable[0]);
  for (int i = 1; i < n; i++) {
    b[i] = b[m - i] = Complex(real: cosTable[i], imaginary: sinTable[i]);
  }

  // Convolution
  ArrayComplex c = circularConvolution(a, b);

  //  c = c.divisionToScalar(n); // Scaling (because this FFT implementation omits it)

  ArrayComplex result = ArrayComplex.fixed(n);
  // Postprocessing

  for (int i = 0; i < n; i++) {
    var real = c[i].real * cosTable[i] + c[i].imaginary * sinTable[i];
    var imag = -c[i].real * sinTable[i] + c[i].imaginary * cosTable[i];

    result[i] = Complex(real: real, imaginary: imag);
  }

  return result;
}