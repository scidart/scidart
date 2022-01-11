import 'dart:math' as math;

import 'package:scidart/src/numdart/numdart.dart';

/// Compute the one-dimensional discrete Fourier Transform.
/// Uses recursive Cooley–Tukey algorithm if N is power of 2 otherwise uses
/// Discrete Fourier Transform algorithm.
/// - [x] : An ArrayComplex with the input
/// - [n] : Length of the transformed axis of the output (optional). If not informed,
/// the length of x will be used
/// If n is smaller than the length of the input, the input is cropped.
/// If it is larger, the input is padded with zeros.
/// If n is not given, the length of the input is used.
/// - [normalization] : Compute the FFT normalization wich is: fft(x)/n (optional default false)
/// - return An ArrayComplex with FFT output
///
/// # References
/// 1. "Fast Fourier Transform (C++, Nim and Python examples)". https://rosettacode.org/wiki/Fast_Fourier_transform#Nim. Retrieved 2021-05-10.
/// 2. "Free small FFT in multiple languages". https://www.nayuki.io/page/free-small-fft-in-multiple-languages. Retrieved 2019-07-23.
/// 3. "looking for fft1d arbitrary length code". https://stackoverflow.com/questions/34655959/looking-for-fft1d-arbitrary-length-code. Retrieved 2019-07-23.
/// 4. "Chirp_Z-transform Bluestein". https://en.wikipedia.org/wiki/Chirp_Z-transform#Bluestein.27s_algorithm. Retrieved 2019-07-24.
/// 5. "numpy.fft.fft". https://docs.scipy.org/doc/numpy/reference/generated/numpy.fft.fft.html#numpy.fft.fft. Retrieved 2019-07-24.
/// 6. "Fast fourier transformation polynomial multiplication". https://www.geeksforgeeks.org/fast-fourier-transformation-poynomial-multiplication/. Retrieved 2019-07-25.
/// 7. "Implementation of the Divide and Conquer DFT via Matrices". https://www.projectrhea.org/rhea/index.php/Implementation_of_the_Divide_and_Conquer_DFT_via_Matrices. Retrieved 2019-07-25.
/// 8. "How to implement the discrete fourier transform". https://www.nayuki.io/page/how-to-implement-the-discrete-fourier-transform. Retrieved 2019-07-25.
/// 9. "Fast Fourier transform". https://en.wikipedia.org/wiki/Fast_Fourier_transform. Retrieved 2021-05-10.
/// 10. "Cooley–Tukey FFT algorithm". https://en.wikipedia.org/wiki/Cooley%E2%80%93Tukey_FFT_algorithm#. Retrieved 2021-05-10.
/// 11. "Discrete Fourier transform". https://en.wikipedia.org/wiki/Discrete_Fourier_transform. Retrieved 2021-05-10.
///
/// # Examples
/// ```dart
/// var x = arrayToComplexArray(Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]));
///
/// fft(x);
///
/// /* output:
/// ArrayComplex([
///   Complex(real: 4.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: -2.41421356),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: -0.41421356),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: 0.41421356),
///   Complex(real: 0.0, imaginary: 0.0),
///   Complex(real: 1.0, imaginary: 2.41421356)
/// ]);
/// */
/// ```
ArrayComplex fft(ArrayComplex x,
    {int? n, bool normalization = false, bool forceDft = false}) {
  var buffer = ArrayComplex.empty();
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
  } else if (isPowerOf2(n) && !forceDft) {
    // It is power of 2, apply cooley tukey algorithm
    res = _cooleyTukey(buffer);
  } else {
    // It is not power of 2, apply discrete fourier transform algorithm
    res = _dft(buffer);
  }

  return normalization ? arrayComplexDivisionToScalar(res, n) : res;
}

ArrayComplex _cooleyTukey(ArrayComplex x) {
  var n = x.length;

  if (n == 0) {
    return ArrayComplex.empty();
  }

  if (n == 1) {
    return ArrayComplex([x[0]]);
  } else {
    var evens = ArrayComplex.empty();
    var odds = ArrayComplex.empty();
    for (var i = 0; i < n; i++) {
      if (isEven(i)) {
        evens.add(x[i]);
      } else {
        odds.add(x[i]);
      }
    }
    var even = _cooleyTukey(evens);
    var odd = _cooleyTukey(odds);

    var result = ArrayComplex.fixed(n);
    var halfn = n ~/ 2;
    for (var k = 0; k < halfn; k++) {
      var exponent = Complex.ri(0.0, -2 * pi * k.toDouble() / n.toDouble());
      var a = complexExp(exponent) * odd[k];
      result[k] = even[k] + a;
      result[k + halfn] = even[k] - a;
    }

    return result;
  }
}

/// Computes the discrete Fourier transform (DFT) of the given complex vector.
/// All the array arguments must be non-null
ArrayComplex _dft(ArrayComplex buffer) {
  var n = buffer.length;
  var out = ArrayComplex.fixed(n);
  for (var k = 0; k < n; k++) {
    // For each output element
    var sumreal = 0.0;
    var sumimag = 0.0;
    for (var t = 0; t < n; t++) {
      // For each input element
      var angle = 2 * math.pi * t * k / n;
      sumreal += buffer[t].real * math.cos(angle) +
          buffer[t].imaginary * math.sin(angle);
      sumimag += -buffer[t].real * math.sin(angle) +
          buffer[t].imaginary * math.cos(angle);
    }
    out[k] = Complex.ri(sumreal, sumimag);
  }

  return out;
}
