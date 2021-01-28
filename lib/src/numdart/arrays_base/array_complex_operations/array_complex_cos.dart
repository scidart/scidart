import 'package:scidart/src/numdart/numbers/complex_operations/complex_cos.dart';

import '../array_complex.dart';

/// # arrayComplexCos
/// Compute the cos for each element of the array
///
/// ## Examples
/// ```dart
/// var c1 = Complex(real: 3.0, imaginary: 4.0);
///
/// print(arrayComplexCos(c1));
///
/// /* expected output:
/// Complex(real: -27.034945603074224, imaginary: -3.8511533348117775)
/// */
/// ```
ArrayComplex arrayComplexCos(ArrayComplex a) {
  var c = ArrayComplex.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = complexCos(a[i]);
  }
  return c;
}
