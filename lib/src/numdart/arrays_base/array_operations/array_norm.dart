import 'dart:math';

import '../array.dart';

/// Calculate the norm of an array
///
/// # Examples
/// ```dart
/// var list = Array([1.0, -3.0, 2.0]);
///
/// print(arrayAddToScalar(list, 2));
///
/// /* output:
/// 3.74165
/// */
/// ```
double arrayNorm(Array a) {
  var s = 0.0;
  for (var i = 0; i < a.length; i++) {
    s += a[i] * a[i];
  }
  return sqrt(s);
}
