import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/fftpack/fftpack.dart';
import 'package:test/test.dart';

void main() {
  test('fft of a signal', () {
    var x = arrayToComplexArray(
        Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0]));

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
    var x = arrayToComplexArray(Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]));

    var X = fft(x);

    print(X);

    // expected FFT
    var XExpected = ArrayComplex([
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: 0.5, imaginary: -2.19064313),
      Complex(real: 0.5, imaginary: 0.24078731),
      Complex(real: 0.5, imaginary: -0.62698017),
      Complex(real: 0.5, imaginary: 0.62698017),
      Complex(real: 0.5, imaginary: -0.24078731),
      Complex(real: 0.5, imaginary: 2.19064313)
    ]);

    var fractionDigits = 8;
    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });

  test('fft of signal with a N < length defined', () {
    var x = arrayToComplexArray(Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]));

    var X = fft(x, n: 6);

    print(X);

    // expected FFT
    var XExpected = ArrayComplex([
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: 2.220446049250313e-16, imaginary: -1.7320508075688776),
      Complex(real: 0.9999999999999998, imaginary: -1.9915985002059197e-16),
      Complex(real: 0.0, imaginary: -2.449293598294706e-16),
      Complex(real: 1.0000000000000004, imaginary: -2.872973975786683e-16),
      Complex(real: 2.220446049250313e-16, imaginary: 1.7320508075688748)]);

    var fractionDigits = 8;
    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });

  test('fft of signal with a N > length defined', () {
    var x = arrayToComplexArray(Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]));

    var X = fft(x, n: 16);

    print(X);

    // expected FFT
    var XExpected = ArrayComplex([
      Complex(real: 4.0, imaginary: 0.0),
      Complex(real: -1.2483028813327446, imaginary: 3.013669746062924),
      Complex(real: -0.9999999999999999, imaginary: -1.0),
      Complex(real: -0.599456183689829, imaginary: 0.24830288133274436),
      Complex(real: 1.2246467991473532e-16, imaginary: -2.0),
      Complex(real: 2.013669746062924, imaginary: 0.8340893189596496),
      Complex(real: -1.0, imaginary: 1.0),
      Complex(real: -0.16591068104035056, imaginary: -0.4005438163101709),
      Complex(real: 0.0, imaginary: 0.0),
      Complex(real: -0.16591068104035078, imaginary: 0.4005438163101709),
      Complex(real: -0.9999999999999999, imaginary: -1.0),
      Complex(real: 2.013669746062924, imaginary: -0.8340893189596492),
      Complex(real: -1.2246467991473532e-16, imaginary: 2.0),
      Complex(real: -0.5994561836898291, imaginary: -0.24830288133274447),
      Complex(real: -1.0, imaginary: 1.0),
      Complex(real: -1.2483028813327441, imaginary: -3.013669746062924)
    ]);

    expect(X, XExpected);
  });
}
