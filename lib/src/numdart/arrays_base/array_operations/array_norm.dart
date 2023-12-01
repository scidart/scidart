import 'dart:math';

import '../array.dart';

/// Calculate the norm of an array
///
/// # Examples
/// ```dart
/// var list = Array([3, 4]);
///
/// print(arrayNorm(list));
///
/// /* output:
/// 5
/// */
/// ```
double arrayNorm(Array a) {
  var s = 0.0;
  for (var i = 0; i < a.length; i++) {
    s += a[i] * a[i];
  }
  return sqrt(s);
}
