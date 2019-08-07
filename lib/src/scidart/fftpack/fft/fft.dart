import 'dart:math';
import 'dart:math' as math;

import 'package:scidart/src/numdart/numdart.dart';

///  Compute the one-dimensional discrete Fourier Transform.
///  [buffer] : A ArrayComplex with the input
///  [n] : optional
///        Length of the transformed axis of the output.
///        If n is smaller than the length of the input, the input is cropped.
///        If it is larger, the input is padded with zeros.
///        If n is not given, the length of the input is used.
///  [normalization] : optional default false
///        Compute the FFT normalization wich is: fft(x)/n
///  return A ArrayComplex with FFT output
///  References
///  ----------
///  .. [1] "Fast Fourier Transform". https://rosettacode.org/wiki/Fast_Fourier_transform#C++. Retrieved 2019-07-23.
///  .. [2] "Free small FFT in multiple languages". https://www.nayuki.io/page/free-small-fft-in-multiple-languages. Retrieved 2019-07-23.
///  .. [3] "looking for fft1d arbitrary length code". https://stackoverflow.com/questions/34655959/looking-for-fft1d-arbitrary-length-code. Retrieved 2019-07-23.
///  .. [4] "Chirp_Z-transform Bluestein". https://en.wikipedia.org/wiki/Chirp_Z-transform#Bluestein.27s_algorithm. Retrieved 2019-07-24.
///  .. [5] "numpy.fft.fft". https://docs.scipy.org/doc/numpy/reference/generated/numpy.fft.fft.html#numpy.fft.fft. Retrieved 2019-07-24.
///  .. [6] "Fast fourier transformation polynomial multiplication". https://www.geeksforgeeks.org/fast-fourier-transformation-poynomial-multiplication/. Retrieved 2019-07-25.
///  .. [7] "Implementation of the Divide and Conquer DFT via Matrices". https://www.projectrhea.org/rhea/index.php/Implementation_of_the_Divide_and_Conquer_DFT_via_Matrices. Retrieved 2019-07-25.
///  .. [8] "How to implement the discrete fourier transform". https://www.nayuki.io/page/how-to-implement-the-discrete-fourier-transform. Retrieved 2019-07-25.
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
ArrayComplex fft(ArrayComplex x, {int n, bool normalization = false}) {
  ArrayComplex buffer;
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
    buffer = arrayComplexConcat(buffer, x);
  }

  ArrayComplex res;
  if (buffer.isEmpty) {
    return ArrayComplex.empty();
  } else if ((n & (n - 1)) == 0) { // It is power of 2
    res = _transformRadix2(buffer);
  } else { // More complicated algorithm for arbitrary sizes
//  return _transformBluestein(buffer); // one option, but didnt work as I expected
//  return _recursive(buffer); // another option, but didnt work as I expected
    res = _dft(buffer);
  }

  return normalization ? arrayComplexDivisionToScalar(res, n) : res;
}

///  Computes the discrete Fourier transform (DFT) of the given complex vector, returning the result back into the vector.
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

///  Computes the discrete Fourier transform (DFT) of the given complex vector, returning the result back into the vector.
///  The vector can have any length. This requires the convolution function, which in turn requires the radix-2 FFT function.
///  Uses Bluestein's chirp z-transform algorithm.
///  fixme: this algorithm don't produced good results, so, I resolve to not use until be fixed
//ArrayComplex _transformBluestein(ArrayComplex buffer) {
//  var n = buffer.length;
//  // Find a power-of-2 convolution length m such that m >= n * 2 + 1
//  if (n >= 0x20000000) {
//    throw FormatException("Array too large");
//  }
//
//  int m = highestOneBit(n) * 4;
//
//  // Trignometric tables
//  Array cosTable = Array.fixed(n);
//  Array sinTable = Array.fixed(n);
//  for (int i = 0; i < n; i++) {
//    int j = (i.toDouble() * i % (n * 2))
//        .toInt(); // This is more accurate than j = i * i
//    cosTable[i] = math.cos(math.pi * j / n);
//    sinTable[i] = math.sin(math.pi * j / n);
//  }
//
//  // Temporary vectors and preprocessing
//  ArrayComplex a = ArrayComplex.fixed(m, initialValue: Complex());
//  for (int i = 0; i < n; i++) {
//    var areal = buffer[i].real * cosTable[i] +
//        buffer[i].imaginary * sinTable[i];
//    var aimag = -buffer[i].real * sinTable[i] +
//        buffer[i].imaginary * cosTable[i];
//    a[i] = Complex(real: areal, imaginary: aimag);
//  }
//
//  ArrayComplex b = ArrayComplex.fixed(m, initialValue: Complex());
//  b[0] = Complex(real: cosTable[0], imaginary: sinTable[0]);
//  for (int i = 1; i < n; i++) {
//    b[i] = b[m - i] = Complex(real: cosTable[i], imaginary: sinTable[i]);
//  }
//
//  // Convolution
//  ArrayComplex c = convolutionCircularComplex(a, b, keepLength: true);
//
//  //  c = c.divisionToScalar(n); // Scaling (because this FFT implementation omits it)
//
//  ArrayComplex result = ArrayComplex.fixed(n);
//  // Postprocessing
//
//  for (int i = 0; i < n; i++) {
//    var real = c[i].real * cosTable[i] + c[i].imaginary * sinTable[i];
//    var imag = -c[i].real * sinTable[i] + c[i].imaginary * cosTable[i];
//
//    result[i] = Complex(real: real, imaginary: imag);
//  }
//
//  return result;
//}

///  Computes the discrete Fourier transform (DFT) of the given complex vector, using
///  recursive divide and counquer method.
///  [buffer] - complex array with the input
///  fixme: this algorithm don't produced good results, so, I resolve to not use until be fixed
//ArrayComplex _recursive(ArrayComplex buffer) {
//  int n = buffer.length;
//
//  // if input contains just one element break recursion.
//  // stop condition of the recursion.
//  if (n == 1) {
//    return ArrayComplex.fixed(1, initialValue: buffer[0]);
//  }
//
//  // shallow copy of buffer
//  var a = buffer; // juntos e shallow now!
//
//  // For storing n complex nth roots of unity
//  var w = ArrayComplex.fixed(n);
//  for (int i = 0; i < n; i++) {
//    double alpha = 2 * math.pi * i / n;
//    w[i] = Complex.ri(cos(alpha), sin(alpha));
//  }
//
//  // even and odd arrays vars
//  var A0 = ArrayComplex.empty();
//  var A1 = ArrayComplex.empty();
//
//  // even indexed coefficients
//  var ind = 0;
//  do {
//    A0.add(a[ind]);
//    ind = ind + 2;
//  } while (ind < n);
//
//  // odd indexed coefficients
//  ind = 1;
//  do {
//    A1.add(a[ind]);
//    ind = ind + 2;
//  } while (ind < n);
//
//  // Recursive call for even indexed coefficients
//  ArrayComplex y0 = _recursive(A0);
//
//  // Recursive call for odd indexed coefficients
//  ArrayComplex y1 = _recursive(A1);
//
//  // for storing values of y0, y1, y2, ..., yn-1.
//  ArrayComplex y = ArrayComplex.fixed(n, initialValue: Complex());
//
//  for (int k = 0; k < n ~/ 2; k++) {
//    y[k] = y0[k] + w[k] * y1[k];
//    y[k + n ~/ 2] = y0[k] - w[k] * y1[k];
//  }
//
//  return y;
//}

///  Computes the discrete Fourier transform (DFT) of the given complex vector.
///  All the array arguments must be non-null
ArrayComplex _dft(ArrayComplex buffer) {
  int n = buffer.length;
  var out = ArrayComplex.fixed(n);
  for (int k = 0; k < n; k++) { // For each output element
    double sumreal = 0;
    double sumimag = 0;
    for (int t = 0; t < n; t++) { // For each input element
      double angle = 2 * math.pi * t * k / n;
      sumreal += buffer[t].real * math.cos(angle) +
          buffer[t].imaginary * math.sin(angle);
      sumimag += -buffer[t].real * math.sin(angle) +
          buffer[t].imaginary * math.cos(angle);
    }
    out[k] = Complex.ri(sumreal, sumimag);
  }

  return out;
}