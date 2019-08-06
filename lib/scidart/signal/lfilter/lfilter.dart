import 'package:scidart/numdart/numdart.dart';

///  Filter data along one-dimension with an IIR or FIR filter.
///  The filter is a direct form II transposed implementation of the standard difference equation.
///  Parameters
///  ----------
///  [b] : Array
///  The numerator coefficient vector sequence.
///  [a] : Array
///  The denominator coefficient vector sequence.
///  [x] : Array
///  An input array.
///  Returns
///  -------
///  [y] : Array
///      Filtered x Array.
///  References
///  ----------
///  .. [1] "Apply a digital filter (direct form II transposed)". https://rosettacode.org/wiki/Apply_a_digital_filter_(direct_form_II_transposed)#Java. Retrieved 2019-08-06.
///  .. [2] "doc scipy.signal.lfilter". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.lfilter.html. Retrieved 2019-08-06.
///  .. [3] "source code scipy.signal.lfilter". https://github.com/scipy/scipy/blob/v1.3.0/scipy/signal/signaltools.py#L1213-L1399. Retrieved 2019-08-06.
///  .. [4] "digital filter". https://en.wikipedia.org/wiki/Digital_filter. Retrieved 2019-08-06.
///  .. [5] "Digital_biquad_filter Direct_form_2". https://en.wikipedia.org/wiki/Digital_biquad_filter#Direct_form_2. Retrieved 2019-08-06.
///  .. [6] "scipy signaltools lfilter function implementation sigtools". https://stackoverflow.com/questions/41698892/scipy-signaltools-lfilter-function-implementation-sigtools. Retrieved 2019-08-06.
///  Examples
///  --------
///  >>> var N = 50.0;
///  >>> var fs = 128;
///  >>> var n = linspace(0, N, num: (N*fs).toInt(), endpoint: false);
///  >>> var f1 = 1; // 1Hz
///  >>> var sg1 = arraySin(arrayMultiplyToScalar(n, 2*pi*f1));
///  >>> var f2 = 10; // 10Hz
///  >>> var sg2 = arraySin(arrayMultiplyToScalar(n, 2*pi*f2));
///  >>> var sg = sg1 + sg2;
///  >>> var nyq = 0.5 * fs; // design filter
///  >>> var fc = 1;
///  >>> var normal_fc = fc / nyq;
///  >>> var numtaps = 30;
///  >>> var b = firwin(numtaps, Array([normal_fc]));
///  >>> var sgFiltered = lfilter(b, Array([1.0]), sg); // filter the signal
Array lfilter(Array b, Array a, Array x) {
  Array result = Array.fixed(x.length);
  for (int i = 0; i < x.length; ++i) {
    double tmp = 0.0;
    for (int j = 0; j < b.length; ++j) {
      if (i - j < 0) continue;
      tmp += b[j] * x[i - j];
    }
    for (int j = 1; j < a.length; ++j) {
      if (i - j < 0) continue;
      tmp -= a[j] * result[i - j];
    }
    tmp /= a[0];
    result[i] = tmp;
  }
  return result;
}
