import '../array_complex.dart';

/// Return an Array without the last element
///
/// # Examples
/// ```dart
/// var list = ArrayComplex([
///   Complex(real: 3.0, imaginary: 4.0),
///   Complex(real: 3.0, imaginary: 4.0) ,
///   Complex(real: 3.0, imaginary: 4.0)]);
///
/// print(list.cos());
///
/// /* expected output:
/// ArrayComplex([Complex(real: -27.034945603074224, imaginary: -3.8511533348117775), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775)])
/// */
/// ```
ArrayComplex arrayComplexTruncateLast(ArrayComplex a) {
  var c = ArrayComplex.fixed(a.length - 1);
  for (var i = 0; i < c.length; i++) {
    c[i] = a[i];
  }
  return c;
}
