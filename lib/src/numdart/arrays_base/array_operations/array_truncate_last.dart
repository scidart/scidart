import '../array.dart';

/// Return an Array without the last element
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(arrayTruncateLast(n));
///
/// /* output:
/// Array([1.0, 2.0])
/// */
/// ```
Array arrayTruncateLast(Array a) {
  var c = Array.fixed(a.length - 1);
  for (var i = 0; i < c.length; i++) {
    c[i] = a[i];
  }
  return c;
}
