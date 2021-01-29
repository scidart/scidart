import '../array.dart';

/// Multiply all the array elements for a number
///
/// # Examples
/// ```dart
/// var list = Array([4.0, 4.0 , 4.0]);
///
/// print(arrayMultiplyToScalar(list, 2));
///
/// /* output:
/// Array([4.0, 4.0, 4.0])
/// */
/// ```
Array arrayMultiplyToScalar(Array a, num b) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = a[i] * b;
  }
  return c;
}
