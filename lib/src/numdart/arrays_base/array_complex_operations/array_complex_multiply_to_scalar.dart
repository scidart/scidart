import 'package:scidart/src/numdart/numbers/complex_operations/complex_multiply_scalar.dart';

import '../array_complex.dart';

/// # arrayComplexMultiplyToScalar
/// Multiply all the array elements for a number
///
/// ## Examples
/// ```dart
/// var list = ArrayComplex([
///   Complex(real: 2.0, imaginary: 2.0),
///   Complex(real: 2.0, imaginary: 2.0) ,
///   Complex(real: 2.0, imaginary: 2.0)]);
///
/// print(arrayComplexMultiplyToScalar(list, 2));
///
/// /* expected output:
/// ArrayComplex([Complex(real: 4.0, imaginary: 4.0), Complex(real: 4.0, imaginary: 4.0), Complex(real: 4.0, imaginary: 4.0)])
/// */
/// ```
ArrayComplex arrayComplexMultiplyToScalar(ArrayComplex a, num b) {
  var c = ArrayComplex.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = complexMultiplyScalar(a[i], b);
  }

  return c;
}
