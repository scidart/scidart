import 'dart:math';

import '../array.dart';

/// Return the index of the first greater element of the array
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(arrayArgMax(n));
///
/// /* expected output:
/// 2
/// */
/// ```
int arrayArgMax(Array a) {
  var el = a.reduce(max);
  return a.indexOf(el);
}
