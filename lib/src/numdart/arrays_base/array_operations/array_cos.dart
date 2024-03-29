import '../../numdart.dart';

/// Compute the cos for each element of the array
///
/// # Examples
/// ```dart
/// var n = Array([0.5*pi, pi, (3/2)*pi, 2*pi]);
/// var cosn = arrayCos(n);
///
/// print(cosn);
///
/// /* expected output:
/// Array([6.123233995736766e-17, -1.0, -1.8369701987210297e-16, 1.0])
/// */
/// ```
Array arrayCos(Array a) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = cos(a[i]); //fixme parallelize
  }
  return c;
}
