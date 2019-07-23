import 'dart:math';

import 'package:scidart/numdart/numdart.dart';

///  Compute the one-dimensional discrete Fourier Transform.
///  [x] A ArrayComplex with the input
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
ArrayComplex fft(ArrayComplex x) {
  int bits = log(x.length) ~/ log(2);
  for (int j = 1; j < x.length / 2; j++) {
    int swapPos = bitReverse(j, bits);
    Complex temp = x[j];
    x[j] = x[swapPos];
    x[swapPos] = temp;
  }

  for (int N = 2; N <= x.length; N <<= 1) {
    for (int i = 0; i < x.length; i += N) {
      for (int k = 0; k < N / 2; k++) {
        int evenIndex = i + k;
        int oddIndex = (i + k + (N / 2)).toInt();
        Complex even = x[evenIndex];
        Complex odd = x[oddIndex];

        double term = (-2 * pi * k) / N;
        Complex exp = Complex(real: cos(term), imaginary: sin(term)) * odd;

        x[evenIndex] = even + exp;
        x[oddIndex] = even - exp;
      }
    }
  }

  return x;
}
