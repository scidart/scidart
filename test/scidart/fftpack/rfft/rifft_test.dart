import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('irfft of a signal with even samples', () {
    var X = ArrayComplex([
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: 0.5000000000000002, imaginary: -2.1906431337674115),
      Complex(real: 0.4999999999999999, imaginary: 0.24078730940376425),
      Complex(real: 0.5000000000000002, imaginary: -0.6269801688313521),
//      Complex(real: 0.4999999999999999, imaginary: 0.6269801688313519),
//      Complex(real: 0.5000000000000019, imaginary: -0.24078730940376336),
//      Complex(real: 0.4999999999999992, imaginary: 2.190643133767411)
    ]);

    var x = rifft(X);

    // expected IFFT calulated with Scipy (from scipy.fftpack import fft, ifft)
    var xExpected = [1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0];

    print(x);

    var fractionDigits = 8;
    for (var i = 0; i < X.length; i++) {
      expect(truncate(x[i], fractionDigits),
          truncate(xExpected[i], fractionDigits));
    }
  });

  test('irfft of a signal with odd samples', () {
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
    for (var i = 0; i < X.length; i++) {
      expect(truncate(x[i], fractionDigits),
          truncate(xExpected[i], fractionDigits));
    }
  });
}
