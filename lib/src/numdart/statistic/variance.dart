import 'package:scidart/src/numdart/arrays_base/array.dart';

import 'mean.dart';

///  Return the variance of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> variance(n);
///
double variance(Array a) {
  double meanA = mean(a);
  double temp = 0;
  for (double el in a) {
    temp += (el - meanA) * (el - meanA);
  }
  return temp / (a.length - 1);
}
