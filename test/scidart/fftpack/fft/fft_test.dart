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
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]).toComplexArray();

    var X = fft(x);

    print(X);

    // expected FFT
    var XExpected = ArrayComplex([
      Complex(real: 3.2469796037174676, imaginary: -5.551115123125783e-17),
      Complex(real: -0.9073573584205016, imaginary: -1.2006891328491447),
      Complex(real: -0.4416768935726024, imaginary: -0.8418543353360777),
      Complex(real: -0.577781289959876, imaginary: 0.8565706957212809),
      Complex(real: 1.2919782073740873, imaginary: 0.8921949574713316),
      Complex(real: 0.41449452955316524, imaginary: -0.74166661892776),
      Complex(real: 2.4338163403573123, imaginary: 1.5366252856188554)]);

    var fractionDigits = 8;
    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });

  test('fft of a odd samples signal', () {
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]).toComplexArray();

    var X = fft(x);

    print(X);

    // expected FFT
    var XExpected = ArrayComplex([
      Complex(real: 3.2469796037174676, imaginary: -5.551115123125783e-17),
      Complex(real: -0.9073573584205016, imaginary: -1.2006891328491447),
      Complex(real: -0.4416768935726024, imaginary: -0.8418543353360777),
      Complex(real: -0.577781289959876, imaginary: 0.8565706957212809),
      Complex(real: 1.2919782073740873, imaginary: 0.8921949574713316),
      Complex(real: 0.41449452955316524, imaginary: -0.74166661892776),
      Complex(real: 2.4338163403573123, imaginary: 1.5366252856188554)]);

    var fractionDigits = 8;
    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });

  test('fft of signal with a N < length defined', () {
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]).toComplexArray();

    var X = fft(x, n: 6);

    print(X);

    // expected FFT
    var XExpected = ArrayComplex([
      Complex(real: 2.5, imaginary: 0.8660254037844385),
      Complex(real: -0.4803327835054294, imaginary: -1.774783970458565),
      Complex(real: 0.14658944223144105, imaginary: -1.0747680368656294),
      Complex(real: 0.2660380487199215, imaginary: 0.9587889985165111),
      Complex(real: 1.407857576492263, imaginary: 0.18105019804537237),
      Complex(real: 0.20443298785776293, imaginary: 0.9577356973847133)]);

    var fractionDigits = 8;
    for (var i = 0; i < X.length; i++) {
      expect(truncate(X[i].real, fractionDigits),
          truncate(XExpected[i].real, fractionDigits));
      expect(truncate(X[i].imaginary, fractionDigits),
          truncate(XExpected[i].imaginary, fractionDigits));
    }
  });

  test('fft of signal with a N > length defined', () {
    var x = Array([1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]).toComplexArray();

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
      Complex(real: -1.2483028813327441, imaginary: -3.013669746062924)]);

    expect(X, XExpected);
  });
}
