import 'package:scidart/src/numdart/numbers/complex_operations/complex_divide_scalar.dart';

import '../array_complex.dart';

///  Divide all the array elements for a number
///  Examples
///  --------
///  >>> var list = ArrayComplex([
///  >>> Complex(real: 4.0, imaginary: 4.0),
///  >>> Complex(real: 8.0, imaginary: 8.0) ,
///  >>> Complex(real: 16.0, imaginary: 16.0)]);
///  >>> arrayComplexDivisionToScalar(list, 2);
///  ArrayComplex([Complex(real: 2.0, imaginary: 2.0), Complex(real: 4.0, imaginary: 4.0), Complex(real: 8.0, imaginary: 8.0)])
ArrayComplex arrayComplexDivisionToScalar(ArrayComplex a, num b) {
  var c = ArrayComplex.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = complexDivideScalar(a[i], b);
  }

  return c;
}
