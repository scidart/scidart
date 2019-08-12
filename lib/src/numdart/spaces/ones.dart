import 'package:scidart/src/numdart/arrays_base/array.dart';

///  Return a new array of given shape and type, filled with ones.
///  Parameters
///  ----------
///  [num] : int that represent the length of the output.
///  Returns
///  -------
///  out : Array
///  Array of ones with the given shape, dtype, and order.
///  See Also
///  --------
///  zeros : Return a new array setting values to zero.
///  References
///  ----------
///  .. [1] "numpy.ones". https://docs.scipy.org/doc/numpy-1.15.1/reference/generated/numpy.ones.html. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> ones(5)
///  Array([ 1.0,  1.0,  1.0,  1.0,  1.0])
Array ones(int num) {
  if (num <= 0) {
    throw("num need be igual or greater than 0");
  }

  var space = Array(List<double>.generate(num, (i) => 1.0));

  return space;
}