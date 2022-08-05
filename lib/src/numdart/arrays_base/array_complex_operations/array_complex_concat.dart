import '../array_complex.dart';

/// Concatenate X in to the current array
///
/// # Examples
/// ```dart
/// var list = ArrayComplex([
///   Complex(real: 3.0, imaginary: 4.0),
///   Complex(real: 3.0, imaginary: 4.0) ,
///   Complex(real: 3.0, imaginary: 4.0)]);
///
/// var b = ArrayComplex([
///   Complex(real: 3.0, imaginary: 4.0)
/// ]);
///
/// print(arrayComplexConcat(list, b));
///
/// /* expected output
/// ArrayComplex([
///   Complex(real: 3.0, imaginary: 4.0),
///   Complex(real: 3.0, imaginary: 4.0) ,
///   Complex(real: 3.0, imaginary: 4.0),
///   Complex(real: 3.0, imaginary: 4.0)
/// ])
/// */`
/// ```
ArrayComplex arrayComplexConcat(ArrayComplex a, ArrayComplex b) {
  return ArrayComplex(a + b);
}
