import 'dart:math' as math;

import 'package:scidart/numdart/fastmath/fastmath.dart' as fmath;

import '../complex.dart';

///  Compute the [cosine](http://mathworld.wolfram.com/Cosine.html)
///  of this complex number.
///
///  Implements the formula:
///
///      cos(a + bi) = cos(a)cosh(b) - sin(a)sinh(b)i
///
///  Examples
///  --------
///  >>> var c1 = Complex(real: 3.0, imaginary: 4.0);
///  >>> c1.cos();
///  Complex(real: -27.034945603074224, imaginary: -3.8511533348117775)
Complex complexCos(Complex a) {
  return Complex(
      real: math.cos(a.real) * fmath.cosh(a.imaginary),
      imaginary: -math.sin(a.real) * fmath.sinh(a.imaginary));
}
