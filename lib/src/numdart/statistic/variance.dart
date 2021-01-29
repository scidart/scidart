import 'package:scidart/src/numdart/arrays_base/array.dart';

import 'mean.dart';

/// Return the variance of the array
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(variance(n));
/// ```
double variance(Array a) {
  var meanA = mean(a);
  var temp = 0.0;
  for (var el in a) {
    temp += (el - meanA) * (el - meanA);
  }
  return temp / (a.length - 1);
}
