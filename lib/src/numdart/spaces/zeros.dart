import 'package:scidart/src/numdart/arrays_base/array.dart';

///  Return a new array of given shape and type, filled with zeros.
///  Parameters:
///  ----------
///  [num] : int that represent the length of the output.
///  Returns:
///  out : Array
///  Array of zeros with the given num.
///  See Also
///  --------
///  ones : Return a new array setting values to one.
///  References
///  ----------
///  .. [1] "numpy.zeroshttps://docs.scipy.org/doc/numpy/reference/generated/numpy.zeros.html. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> import 'package:scidart/src/numdart/numdart.dart';
///  >>> zeros(5);
/// Array([ 0.,  0.,  0.,  0.,  0.])
Array zeros(int num) {
  if (num <= 0) {
    throw("num need be igual or greater than 0");
  }

  var space = Array(List<double>.generate(num, (i) => 0.0));

  return space;
}