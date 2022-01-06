import 'package:scidart/src/numdart/numbers/complex.dart';

import '../array.dart';
import '../array_complex.dart';

/// Convert an Array to ArrayComplex
///
/// # Examples
/// ```dart
/// var list = Array([1.0, 2.0 , 3.0]);
///
/// print(arrayToComplexArray(list));
///
/// /* output:
/// ArrayComplex([Complex(real: 1.0, imaginary: 0.0), Complex(real: 2.0, imaginary: 0.0) , Complex(real: 3.0, imaginary: 0.0)])
/// */
/// ```
ArrayComplex arrayToComplexArray(Array a) {
  var c = ArrayComplex.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = Complex(real: a[i]);
  }
  return c;
}
