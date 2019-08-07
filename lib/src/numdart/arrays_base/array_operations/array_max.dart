import 'dart:math';

import '../array.dart';

///  Return the sum of all elements of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> arraySum(n);
///  6.0
double arrayMax(Array a) {
  return a.reduce(max);
}
