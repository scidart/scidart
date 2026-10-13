import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('irfft of a signal with odd samples', () {
    var X = ArrayComplex([
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: 0.5000000000000002, imaginary: -2.1906431337674115),
      Complex(real: 0.4999999999999999, imaginary: 0.24078730940376425),
      Complex(real: 0.5000000000000002, imaginary: -0.6269801688313521),
//      Complex(real: 0.4999999999999999, imaginary: 0.6269801688313519),
//      Complex(real: 0.5000000000000019, imaginary: -0.24078730940376336),
//      Complex(real: 0.4999999999999992, imaginary: 2.190643133767411)
    ]);

    var x = rifft(X, n: 7);

    // expected IFFT calulated with Scipy (from scipy.fftpack import fft, ifft)
    var xExpected = [1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0];

    print(x);

    var fractionDigits = 8;
    expect(x.length, xExpected.length);
    for (var i = 0; i < xExpected.length; i++) {
      expect(truncate(x[i], fractionDigits),
          truncate(xExpected[i], fractionDigits));
    }
  });

  test('irfft of a signal with even samples', () {
    var X = ArrayComplex([
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: -2.414213562373095),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: -0.4142135623730949),
      Complex(real: 0.0, imaginary: 0.0),
//          Complex(real: 0.9999999999999999, imaginary: 0.4142135623730949),
//          Complex(real: 0.0, imaginary: 0.0),
//          Complex(real: 0.9999999999999997, imaginary: 2.414213562373095)
    ]);

    var x = rifft(X);

    // expected IFFT calulated with Scipy (from scipy.fftpack import fft, ifft)
    var xExpected = [1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0];

    print(x);

    var fractionDigits = 8;
    expect(x.length, xExpected.length);
    for (var i = 0; i < xExpected.length; i++) {
      expect(truncate(x[i], fractionDigits),
          truncate(xExpected[i], fractionDigits));
    }
  });

  test('irfft matches numpy.fft.irfft, issue #47', () {
    var X = ArrayComplex([
      Complex(real: 31.108143074615633, imaginary: -4.037293439117874),
      Complex(real: -22.413467454124664, imaginary: 0.5718233105591632),
      Complex(real: 11.988831263334843, imaginary: 0.04538347618383224),
    ]);

    var x = rifft(X);

    // np.fft.irfft(X)
    var xExpected = [
      -0.4324901425747125,
      4.493916297540616,
      21.98097731154995,
      5.065739608099778
    ];
    expect(x.length, xExpected.length);
    for (var i = 0; i < xExpected.length; i++) {
      expect(x[i], closeTo(xExpected[i], 1e-9));
    }
  });

  test('rifft(rfft(x)) recovers x for even and odd lengths', () {
    for (var signal in [
      Array([1.0, -2.0, 3.0, 4.0, 0.5, -1.0]),
      Array([1.0, -2.0, 3.0, 4.0, 0.5]),
    ]) {
      var x = rifft(rfft(signal), n: signal.length);
      expect(x.length, signal.length);
      for (var i = 0; i < signal.length; i++) {
        expect(x[i], closeTo(signal[i], 1e-9));
      }
    }
  });
}
