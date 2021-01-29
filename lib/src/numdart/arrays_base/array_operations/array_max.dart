import 'dart:math';

import '../array.dart';

/// Return the greater element in the array
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(arraySum(n));
///
/// /* expected output:
/// 3
/// */
/// ```
double arrayMax(Array a) {
  return a.reduce(max);
}
