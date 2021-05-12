import 'dart:math' as math;

import '../array.dart';

/// Compute the power for each element of the array [a] by [exponent]
///
/// # Examples
/// ```dart
/// var n = Array([4, 4, 4]);
///
/// print(arrayPow(n, 2));
///
/// /* output:
/// Array([16, 16, 16])
/// */
/// ```
Array arrayPow(Array a, double exponent) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = math.pow(a[i], exponent).toDouble();
  }
  return c;
}
