import 'package:scidart/scidart.dart';
import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('rfft of a signal', () {
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]);

    var X = rfft(x);
    print(X);

    // expected FFT calulated with Scipy (from scipy.fftpack import fft, ifft)
    var XExpected = ArrayComplex([
      Complex.ri(4.0, 0),
      Complex.ri(1.0, -2.41421356),
      Complex.ri(0, 0),
      Complex.ri(1.0, -0.41421356),
      Complex.ri(0.0, 0.0)]);

    var fractionDigits = 8;

    arrayComplexTruncateEachElement(X, fractionDigits);
    arrayComplexTruncateEachElement(XExpected, fractionDigits);

    expect(X, XExpected);
  });

  test('rfft of sin', () {
    var N = 10.0;
    var fs = 10.0;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);

    var f1 = 1; // 1Hz
    var x = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

    var X = rfft(x);

    // expected FFT calulated with Scipy (from scipy.fftpack import fft, ifft)
    var XExpected = ArrayComplex([
      Complex.ri(2.36171372e-14, 0.00000000e+00),
      Complex.ri(-9.00541287e-15, 1.07904914e-14),
      Complex.ri(3.62254533e-15, -6.31142149e-15),
      Complex.ri(2.71761134e-15, -5.45889252e-16),
      Complex.ri(1.15561038e-14, -2.68677154e-15),
      Complex.ri(-3.55247667e-16, 1.82509185e-14),
      Complex.ri(-8.61825328e-15, -6.20019692e-15),
      Complex.ri(9.93348561e-15, 6.59183943e-15),
      Complex.ri(1.15990293e-14, -2.92138105e-15),
      Complex.ri(-5.90169617e-15, 1.14877810e-14),
      Complex.ri(-1.42108547e-14, -5.00000000e+01),
      Complex.ri(-1.46545974e-14, -2.03694215e-14),
      Complex.ri(-1.77089966e-16, -1.32982321e-14),
      Complex.ri(6.90135294e-15, -5.64324728e-15),
      Complex.ri(-4.84270886e-16, 3.45737917e-15),
      Complex.ri(4.66128841e-15, -2.06993876e-14),
      Complex.ri(1.45703920e-14, 4.30284012e-15),
      Complex.ri(1.13594668e-14, 1.00462979e-15),
      Complex.ri(1.19369103e-14, 1.14015692e-14),
      Complex.ri(7.86242669e-15, 1.07231746e-14),
      Complex.ri(2.46566275e-15, 1.50149484e-14),
      Complex.ri(-1.88187583e-14, 1.06240163e-14),
      Complex.ri(-5.39608870e-15, -1.23392838e-15),
      Complex.ri(-4.96090167e-15, -5.91412460e-16),
      Complex.ri(9.68393922e-15, 3.66152235e-15),
      Complex.ri(-3.99340142e-15, 1.94323044e-14),
      Complex.ri(-2.29295458e-14, -2.76843378e-15),
      Complex.ri(2.66489842e-15, 6.50990959e-16),
      Complex.ri(6.66942903e-15, -8.54884322e-15),
      Complex.ri(5.63715458e-16, 1.32512667e-14),
      Complex.ri(-3.90099173e-14, 1.17488528e-14),
      Complex.ri(5.37857614e-15, -1.02858522e-14),
      Complex.ri(-1.89571320e-14, -1.53589379e-14),
      Complex.ri(-2.03953716e-15, -8.52221639e-15),
      Complex.ri(-2.88530594e-15, -1.15373857e-14),
      Complex.ri(3.25194357e-15, -1.97857858e-14),
      Complex.ri(1.31168472e-14, -2.31625352e-15),
      Complex.ri(4.03919598e-15, -6.73319548e-15),
      Complex.ri(1.90104678e-14, -9.20990139e-15),
      Complex.ri(1.53647114e-14, 1.50961066e-14),
      Complex.ri(-7.10542736e-15, 5.32907052e-15),
      Complex.ri(1.07202670e-14, 5.37459841e-15),
      Complex.ri(-1.09362265e-15, 1.17265770e-14),
      Complex.ri(-7.03213846e-15, -1.47132042e-15),
      Complex.ri(1.46800666e-14, 5.46062569e-15),
      Complex.ri(2.55865110e-15, 1.67726797e-14),
      Complex.ri(-1.64435049e-14, 9.31653272e-15),
      Complex.ri(-1.13369658e-14, -9.39077069e-15),
      Complex.ri(-1.49679805e-14, 1.65843075e-15),
      Complex.ri(2.07372360e-14, -1.67337435e-14),
      Complex.ri(-1.54627133e-14, 0.00000000e+00)
    ]);
    var fractionDigits = 8;

    arrayComplexTruncateEachElement(X, fractionDigits);
    arrayComplexTruncateEachElement(XExpected, fractionDigits);

    print(X);
    print(XExpected);

    expect(X, XExpected);
  });
}
