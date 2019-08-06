import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fftpack.dart';
import 'package:test/test.dart';

void main() {
  test('rfft of a signal', () {
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]);

    var X = rfft(x);

    // expected FFT calulated with Scipy (from scipy.fftpack import fft, ifft)
    var XExpected = [
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: -2.41421356),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: -0.41421356),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: 0.41421356),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: 2.41421356)
    ];

    var fractionDigits = 8;

    expect(arrayTruncateEachElement(X, fractionDigits),
        arrayComplexTruncateEachElement(XExpected, fractionDigits));

    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });
}
