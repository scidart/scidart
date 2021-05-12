import '../array.dart';

/// Add a number for each array element
///
/// # Examples
/// ```dart
/// var list = Array([4.0, 4.0 , 4.0]);
///
/// print(arrayAddToScalar(list, 2));
///
/// /* output:
/// Array([6.0, 6.0, 6.0])
/// */
/// ```
Array arrayAddToScalar(Array a, num b) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = a[i] + b;
  }
  return c;
}
