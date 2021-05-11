import 'package:scidart/numdart.dart';
import 'dart:math' as math;

/// Calculate natural exponent for any number complex number: e^(x+(y*i)).
/// It's a generatlization of Euler’s formula: e^(i*y) = cos(y) + i*sen(y).
/// - [exponent] : a complex number
///
/// # Examples
/// ```dart
/// var c1 = Complex(real: 4.0, imaginary: 4.0);
/// print(complexExp(c1));
///
/// /* output:
/// Complex(real: -3.074932320639359, imaginary: 6.71884969742825)
/// */
/// ```
///
/// # References
/// 1. "Understanding imaginary exponents". https://math.stackexchange.com/a/9777 . Retrieved 2021-05-10.
/// 2. "Exponential Form". https://tutorial.math.lamar.edu/Extras/ComplexPrimer/Forms.aspx . Retrieved 2021-05-10.
/// 3. "Euler's formula". https://en.wikipedia.org/wiki/Euler%27s_formula . Retrieved 2021-05-10.
Complex complexExp(Complex exponent) {
  return Complex.ri(expFast(exponent.real) * math.cos(exponent.imaginary),
      expFast(exponent.real) * math.sin(exponent.imaginary));
}
