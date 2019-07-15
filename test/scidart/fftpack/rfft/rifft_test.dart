import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fftpack.dart';
import 'package:test/test.dart';

void main() {
  test('irfft of a signal', () {
    var X = ArrayComplex.fromList([
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: -2.41421356),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: -0.41421356),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: 0.41421356),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: 1.0, imaginary: 2.41421356)
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
