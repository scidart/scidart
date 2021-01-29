import 'dart:math';

import '../array.dart';

/// Return the sum of all elements of the array
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(arraySum(n));
///
/// /* expected output:
/// 6.0
/// */
/// ```
double arrayMin(Array a) {
  return a.reduce(min);
}
