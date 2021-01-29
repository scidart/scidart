import '../array.dart';

/// Return the sum of all elements of the array
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(arraySum(n));
///
/// /* output:
/// 6.0
/// */
/// ```
double arraySum(Array a) {
  var sum = 0.0;
  for (var i = 0; i < a.length; i++) {
    sum += a[i];
  }
  return sum;
}
