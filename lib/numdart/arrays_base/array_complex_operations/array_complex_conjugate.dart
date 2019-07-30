import 'package:scidart/numdart/numbers/complex_operations/complex_conjugate.dart';

import '../array_complex.dart';

///  Conjugate of all elements of the current array
///  Examples
///  --------
///  >>> var list = ArrayComplex([
///  >>> Complex(real: 1.0, imaginary: 1.0),
///  >>> Complex(real: 2.0, imaginary: 2.0) ,
///  >>> Complex(real: 3.0, imaginary: 3.0) ]);
///  >>> arrayComplexConjugate(list);
///  ArrayComplex([Complex(real: 1.0, imaginary: -1.0), Complex(real: 2.0, imaginary: -2.0), Complex(real: 3.0, imaginary: -3.0)])
ArrayComplex arrayComplexConjugate(ArrayComplex a) {
  var c = ArrayComplex.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = complexConjugate(a[i]);
  }
  return c;
}
