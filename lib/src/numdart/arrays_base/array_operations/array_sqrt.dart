import 'dart:math' as math;

import '../array.dart';

///  Compute the square root for each element of the array
///  Examples
///  --------
///  >>> var n = Array([4, 4, 4]);
///  >>> arraySqrt(n);
///  Array([2, 2, 2])
Array arraySqrt(Array a) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = math.sqrt(a[i]);
  }
  return c;
}
