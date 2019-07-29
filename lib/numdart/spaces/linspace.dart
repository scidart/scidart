import 'package:scidart/numdart/arrays_base/array.dart';

///  Return evenly spaced numbers over a specified interval.
///  Returns `num` evenly spaced samples, calculated over the
///  interval [`start`, `stop`].
///  Parameters
///  ----------
///  [start] : double
///  The starting value of the sequence.
///  [stop] : double
///  The end value of the sequence, unless `endpoint` is set to False.
///  In that case, the sequence consists of all but the last of ``num + 1``
///  evenly spaced samples, so that `stop` is excluded.  Note that the step
///  size changes when `endpoint` is false.
///  [num] : int, optional
///  Number of samples to generate. Default is 50. Must be non-negative.
///  [endpoint] : bool, optional
///  If true, `stop` is the last sample. Otherwise, it is not included.
///  Default is True.
///  Returns
///  -------
///  samples : [Array]
///  There are `num` equally spaced samples in the closed interval
///  ``[start, stop]`` or the half-open interval ``[start, stop)``
///  (depending on whether `endpoint` is True or False).
///  See Also
///  --------
///  arange : Similar to `linspace`, but uses a step size (instead of the
///  number of samples).
///  References
///  ----------
///  .. [1] "How does Octaves linspace function work internally". https:///www.quora.com/How-does-Octaves-linspace-function-work-internally. Retrieved 2019-07-15.
///  .. [2] "Dart: create a list from 0 to N". https:///stackoverflow.com/a/37799195/6846888. Retrieved 2019-07-15.
///  .. [2] "numpy.linspace". https://docs.scipy.org/doc/numpy/reference/generated/numpy.linspace.html. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> linspace(2.0, 3.0, num: 5);
///  Array([ 2.  ,  2.25,  2.5 ,  2.75,  3.  ])
///  >>> linspace(2.0, 3.0, num: 5, endpoint: false);
///  Array([ 2. ,  2.2,  2.4,  2.6,  2.8])
Array linspace(double start, double stop, {int num=50, bool endpoint=true}) {
  if (num <= 0) {
    throw("num need be igual or greater than 0");
  }

  double delta;
  if (endpoint) {
    delta = (stop-start)/(num-1);
  } else {
    delta = (stop-start)/num;
  }

  var space = Array(List<double>.generate(num, (i) => start + delta*i));

  return space;
}