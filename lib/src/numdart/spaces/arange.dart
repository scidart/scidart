import 'package:scidart/src/numdart/arrays_base/array.dart';

///  Return evenly spaced values within a given interval.
///  Values are generated within the half-open interval [start, stop) (in other words, the interval including start but excluding stop).
///  When using a non-integer step, such as 0.1, It is better to use linspace.
///  Parameters:
///  ----------
///  [start] : int, optional
///  Start of interval. The interval includes this value. The default start value is 0.
///  [stop] : number
///  End of interval. The interval does not include this value, except in some cases where step is not an integer and floating point round-off affects the length of out.
///  [step] : int, optional
///  Spacing between values. For any output out, this is the distance between two adjacent values, out[i+1] - out[i]. The default step size is 1. If step is specified as a position argument, start must also be given.
///  Returns:
///  arange : [Array]
///  Array of evenly spaced values.
///  References
///  ----------
///  .. [1] "numpy.arange". https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.arange.html. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> import 'package:scidart/src/numdart/numdart.dart';
///  >>> arange(stop: 3);
///  Array([0, 1, 2])
///  >>> arange(start: 3, stop: 7)
///  Array([3, 4, 5, 6])
///  >>> arange(start: 3, stop: 7, step: 2)
///  Array([3, 5])
Array arange({int start = 0, int stop = 10, int step=1}) {
  var N = (stop - start) ~/ step; ///https:///stackoverflow.com/a/52479342/6846888

  var space = Array(List<double>.generate(N, (i) => (start + i * step).toDouble()));

  return space;
}