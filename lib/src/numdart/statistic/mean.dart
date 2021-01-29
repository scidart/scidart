import 'package:scidart/src/numdart/arrays_base/arrays_base.dart';

/// Return the mean of all elements of the array
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(mean(n));
///
/// /* output:
/// 2.0
/// */
/// ```
double mean(Array a) {
  return arraySum(a) / a.length;
}
