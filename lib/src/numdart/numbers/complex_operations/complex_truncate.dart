import 'package:scidart/src/numdart/numbers/complex.dart';
import 'package:scidart/src/numdart/numbers/double.dart';

///  Truncate the real and imaginary part of a imaginary number. This function is very useful
///  for compere two double numbers.
///  [val] : a Complex value
///  [fractionDigits] : number of decimal digits
///  Examples
///  --------
///  >>> complexTruncate(Complex.ri(1.4747474747474747, 1.4747474747474747), 3);
///  >>> Complex(real: 1.475, imaginary: 1.475);
Complex complexTruncate(Complex val, int fractionDigits) {
  return Complex.ri(truncate(val.real, fractionDigits),
      truncate(val.imaginary, fractionDigits));
}
