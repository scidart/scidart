import 'package:scidart/numdart.dart';

/// Return the array complex reversed
///
/// # Examples
/// ```dart
/// var n = ArrayComplex([
///   Complex(real: 1, imaginary: 1),
///   Complex(real: 2, imaginary: 2),
///   Complex(real: 3, imaginary: 3)
/// ]);
///
/// print(arrayComplexReverse(n));
///
/// /* output:
/// ArrayComplex([
///   Complex(real: 3.0, imaginary: 3.0),
///   Complex(real: 2.0, imaginary: 2.0),
///   Complex(real: 1.0, imaginary: 1.0)]
/// )
/// */
/// ```
ArrayComplex arrayComplexReverse(ArrayComplex a) {
  var c = ArrayComplex.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[a.length - 1 - i] = a[i];
  }
  return c;
}
