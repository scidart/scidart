import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fftpack.dart';
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
    var fs = 128.0;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);

    var f1 = 1; // 1Hz
    var x = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

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
}
