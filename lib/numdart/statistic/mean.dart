import 'package:scidart/numdart/array/array.dart';

///  Return the mean of all elements of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> n.mean();
///  2.0
double mean(Array a) {
  return a.sum() / a.length;
}
