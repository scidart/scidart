import '../array_complex.dart';

/// Sum two arrays
///
/// # Examples
/// ```dart
/// var list = ArrayComplex([
///   Complex(real: 1, imaginary: 1),
///   Complex(real: 1, imaginary: 1) ,
///   Complex(real: 1, imaginary: 1)]);
/// var list2 = ArrayComplex([
///   Complex(real: 1, imaginary: 1),
///   Complex(real: 1, imaginary: 1),
///   Complex(real: 1, imaginary: 1)]);
///
/// print(list.sum(list2));
///
/// /* expected output:
/// ArrayComplex([Complex(real: 2.0, imaginary: 2.0), Complex(real: 2.0, imaginary: 2.0), Complex(real: 2.0, imaginary: 2.0)])
/// */
/// ```
ArrayComplex arrayComplexSum(ArrayComplex a, ArrayComplex b) {
  var c = ArrayComplex.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = a[i] + b[i];
  }
  return c;
}
