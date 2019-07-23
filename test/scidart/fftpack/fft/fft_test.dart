import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fftpack.dart';
import 'package:test/test.dart';

void main() {
  test('fft of a signal', () {
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]).toComplexArray();

    var X = fft(x);

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
    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });

  test('fft of a odd samples signal', () {
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.5, 0.0, 0.0, 0.0]).toComplexArray();

    var X = fft(x);

    print(X);

//    [4. +0.j
//    0.5-2.19064313j
//    0.5+0.24078731j
//    0.5-0.62698017j
//    0.5+0.62698017j
//    0.5-0.24078731j
//    0.5+2.19064313j]
//
//    ArrayComplex([
//      Complex(real: 4.5, imaginary: 0.0),
//      Complex(real: 0.5000000000000002, imaginary: -2.414213562373095),
//      Complex(real: 0.5, imaginary: 0.0),
//      Complex(real: 0.5000000000000002, imaginary: -0.4142135623730949),
//      Complex(real: 0.5, imaginary: 0.0),
//      Complex(real: 0.5, imaginary: 0.4142135623730949),
//      Complex(real: 0.5, imaginary: 0.0),
//      Complex(real: 0.4999999999999997, imaginary: 2.414213562373095)])

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
    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });
}
