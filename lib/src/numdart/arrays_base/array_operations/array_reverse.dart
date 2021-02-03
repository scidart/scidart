import '../array.dart';

/// Return the array reversed
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(arrayReverse(n));
///
/// /* output:
/// Array([3.0, 2.0, 1.0])
/// */
/// ```
Array arrayReverse(Array a) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[a.length - 1 - i] = a[i];
  }
  return c;
}
