import 'dart:math' as math;

import '../array.dart';

///  Compute the square root for each element of the array
///  Examples
///  --------
///  >>> var n = Array([4, 4, 4]);
///  >>> arrayPow(n, 2);
///  Array([16, 16, 16])
Array arrayPow(Array a, double exponent) {
  var c = Array.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = math.pow(a[i], exponent);
  }
  return c;
}
