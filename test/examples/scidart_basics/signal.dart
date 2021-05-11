import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('signal', () {
    // sample signals for test
    var x = arrayConcat([zeros(8), ones(8)]);
    var y = arrayConcat([ones(8), zeros(8)]);

    //-------- convolution -----------//
    // simple numeric convolution
    print('convolution');
    print(convolution(x, y));

    // compute the convolution using FFT, that will be more fast only if:
    // x.length + y.length is equal power of 2;
    print(convolution(x, y, fast: true));

    // compute the convolution for complex signals using FFT
    print(convolutionComplex(arrayToComplexArray(x), arrayToComplexArray(y)));

    // compute the circular convolution for the complex signals
    print(convolutionCircularComplex(
        arrayToComplexArray(x), arrayToComplexArray(y)));

    //-------- FIR filter -----------//
    // generate the test signal for filter
    // a sum of sine waves with 1Hz and 10Hz, 50 samples and
    // sample frequency (fs) 128Hz
    var N = 50.0;
    var fs = 128;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);
    var f1 = 1; // 1Hz
    var sg1 = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));
    var f2 = 10; // 10Hz
    var sg2 = arraySin(arrayMultiplyToScalar(n, 2 * pi * f2));
    var sg = sg1 + sg2;

    // design a FIR filter low pass with cut frequency at 1Hz, the objective is
    // remove the 10Hz sine wave signal
    var nyq = 0.5 * fs; // nyquist frequency
    var fc = 1; // cut frequency 1Hz
    var normal_fc = fc / nyq; // frequency normalization for digital filters
    var numtaps = 30; // attenuation of the filter after cut frequency

    // generation of the filter coefficients
    var b = firwin(numtaps, Array([normal_fc]));
    print('FIR');
    print(b);

    //-------- Digital filter application -----------//
    print('digital filter application');
    // Apply the filter on the signal using lfilter function
    // lfilter uses direct form II transposed, for FIR filter
    // the a coefficient is 1.0
    var sgFiltered = lfilter(b, Array([1.0]), sg);

    print(sg); // show the original signal
    print(sgFiltered); // show the filtered signal

    //-------- peaks -----------//
    print('peaks');
    var pk = findPeaks(sgFiltered);
    print(pk[0]); // print the indexes of the peaks found in the signal
    print(pk[1]); // print the values of the peaks found in the signal

    //-------- window functions -----------//
    // generate a backmanharris window with x length
    print('window functions');
    var wBh = blackmanharris(x.length);
    print(x * wBh); // apply the windows on the signal

    // the windows available can be get with getWindow
    print(getWindow('hann', x.length)); // hann window

    // for kaiser window, we need pass beta (double value)
    print(getWindow(['kaiser', 2.0], x.length));
  });
}
