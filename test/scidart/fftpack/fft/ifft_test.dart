import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fftpack.dart';
import 'package:test/test.dart';

void main() {
  test('ifft of a signal', () {
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

    var x = ifft(X);

    // expected IFFT calulated with Scipy (from scipy.fftpack import fft, ifft)
    var xExpected = [
      Complex(real: 1.00000000e+00, imaginary: 0.00000000e+00),
      Complex(real: 9.99999999e-01, imaginary: -5.55111512e-17),
      Complex(real: 1.00000000e+00, imaginary: 0.00000000e+00),
      Complex(real: 9.99999999e-01, imaginary: -5.55111512e-17),
      Complex(real: 0.00000000e+00, imaginary: 0.00000000e+00),
      Complex(real: 8.39015857e-10, imaginary: 5.55111512e-17),
      Complex(real: 0.00000000e+00, imaginary: 0.00000000e+00),
      Complex(real: 8.39015857e-10, imaginary: 5.55111512e-17)
    ];

    print(x);

    var fractionDigits = 8;
    for (var i = 0; i < X.length; i++) {
      expect(truncate(xExpected[i].real, fractionDigits),
          truncate(xExpected[i].real, fractionDigits));

      expect(truncate(x[i].imaginary, fractionDigits),
          truncate(xExpected[i].imaginary, fractionDigits));
    }
  });
}
