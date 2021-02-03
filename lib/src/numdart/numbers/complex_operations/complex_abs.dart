import 'package:scidart/src/numdart/geometric/hypotenuse.dart';
import 'package:scidart/src/numdart/numbers/complex.dart';

/// Return a double that represent the absolute value of a complex number
///
/// # Examples
/// ```dart
/// var c1 = Complex(real: 3.0, imaginary: 4.0);
///
/// print(c1.abs());
///
/// /* output:
/// 5.0
/// */
/// ```
double complexAbs(Complex a) {
  return hypotenuse(a.real, a.imaginary);
}
