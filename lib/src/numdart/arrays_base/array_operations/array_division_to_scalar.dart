import '../array.dart';

/// Divide all the array elements for a number
///
/// # Examples
/// ```dart
/// var list = Array([4.0, 8.0 , 16.0]);
///
/// print(arrayDivisionToScalar(list, 2));
///
/// /* expected output:
/// Array([2.0, 4.0, 8.0])
/// */
/// ```
Array arrayDivisionToScalar(Array a, num b) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = a[i] / b;
  }
  return c;
}
