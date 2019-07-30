import 'package:scidart/numdart/geometric/hypotenuse.dart';
import 'package:scidart/numdart/numbers/complex.dart';

///  Return a double that represent the absolute value of a complex number
///  Examples
///  --------
///  >>> var c1 = Complex(real: 3.0, imaginary: 4.0);
///  >>> c1.abs();
///  >>> 5.0
double complexAbs(Complex a) {
  return hypotenuse(a.real, a.imaginary);
}
