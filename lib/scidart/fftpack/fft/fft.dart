import 'dart:math';

import 'package:scidart/numdart/numdart.dart';

///  Compute the one-dimensional discrete Fourier Transform.
///  [buffer] A ArrayComplex with the input
///  return A ArrayComplex with FFT output
///  References
///  ----------
///  .. [1] "Fast Fourier Transform". // https://rosettacode.org/wiki/Fast_Fourier_transform#C++. Retrieved 2019-07-23.
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
  if (x.length == 0) {
    return ArrayComplex.empty();
  }
  else if ((n & (n - 1)) == 0) { // Is power of 2
    return _transformRadix2(x);
  }
  else { // More complicated algorithm for arbitrary sizes
    return transformBluestein(real, imag);
  }


  var buffer = ArrayComplex.empty();
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

  buffer = ArrayComplex(x);

  return buffer;
}

///  Computes the discrete Fourier transform (DFT) of the given complex vector, storing the result back into the vector.
///  The vector's length must be a power of 2. Uses the Cooley-Tukey decimation-in-time radix-2 algorithm.
ArrayComplex _transformRadix2(ArrayComplex buffer) {
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

//https://www.nayuki.io/res/free-small-fft-in-multiple-languages/Fft.java
//https://stackoverflow.com/questions/34655959/looking-for-fft1d-arbitrary-length-code

/*
	 * Computes the discrete Fourier transform (DFT) of the given complex vector, storing the result back into the vector.
	 * The vector can have any length. This requires the convolution function, which in turn requires the radix-2 FFT function.
	 * Uses Bluestein's chirp z-transform algorithm.
	 */
ArrayComplex transformBluestein(ArrayComplex buffer) {
  var n = buffer.length;
  // Find a power-of-2 convolution length m such that m >= n * 2 + 1
  if (n >= 0x20000000) {
    throw FormatException("Array too large");
  }

  int m = highestOneBit(n) * 4;

// Trignometric tables
  double[] cosTable = new double[n];
  double[] sinTable = new double[n];
  for (int i = 0; i < n; i++) {
    int j = (int)(
        (long)i * i % (n * 2)); // This is more accurate than j = i * i
  cosTable[i] = Math.cos(Math.PI * j / n);
  sinTable[i] = Math.sin(Math.PI * j / n);
  }

// Temporary vectors and preprocessing
  double[] areal = new double[m];
  double[] aimag = new double[m];
  for (int i = 0; i < n; i++) {
  areal[i] = real[i] * cosTable[i] + imag[i] * sinTable[i];
  aimag[i] = -real[i] * sinTable[i] + imag[i] * cosTable[i];
  }
  double[] breal = new double[m];
  double[] bimag = new double[m];
  breal[0] = cosTable[0];
  bimag[0] = sinTable[0];
  for (int i = 1; i < n; i++) {
  breal[i] = breal[m - i] = cosTable[i];
  bimag[i] = bimag[m - i] = sinTable[i];
  }

// Convolution
  double[] creal = new double[m];
  double[] cimag = new double[m];
  convolve(areal, aimag, breal, bimag, creal, cimag);

// Postprocessing
  for (int i = 0; i < n; i++) {
  real[i] = creal[i] * cosTable[i] + cimag[i] * sinTable[i];
  imag[i] = -creal[i] * sinTable[i] + cimag[i] * cosTable[i];
  }
}

int highestOneBit(int i) {
  // HD, Figure 3-1
  i |= (i >> 1);
  i |= (i >> 2);
  i |= (i >> 4);
  i |= (i >> 8);
  i |= (i >> 16);
  return i - (i >>> 1);
}