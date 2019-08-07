import '../complex.dart';

///  Return the conjugate of a complex number
///  Examples
///  --------
///  >>> var c1 = Complex(real: 1, imaginary: -3);
///  >>> c1.conjugate();
///  >>> Complex(real: 1.0, imaginary: 3.0)
Complex complexConjugate(Complex a) {
  return Complex(real: a.real, imaginary: -a.imaginary);
}
