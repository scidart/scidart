import 'package:scidart/src/numdart/arrays_base/arrays_base.dart';

///  Return the mean of all elements of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> n.mean();
///  2.0
double mean(Array a) {
  return arraySum(a) / a.length;
}
