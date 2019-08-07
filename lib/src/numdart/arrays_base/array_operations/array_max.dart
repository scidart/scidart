import 'dart:math';

import '../array.dart';

///  Return the greater element in the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> arraySum(n);
///  3
double arrayMax(Array a) {
  return a.reduce(max);
}
