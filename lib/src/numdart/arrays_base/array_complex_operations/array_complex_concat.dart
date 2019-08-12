import '../array_complex.dart';

///  Concatenate X in to the current array
///  Examples
///  >>> var list = ArrayComplex([
///  >>> Complex(real: 3.0, imaginary: 4.0),
///  >>> Complex(real: 3.0, imaginary: 4.0) ,
///  >>> Complex(real: 3.0, imaginary: 4.0)]);
///  >>> var b = ArrayComplex([
///  >>> Complex(real: 3.0, imaginary: 4.0)
///  >>> ]);
///  >>> arrayComplexConcat(list, b);
///  ArrayComplex([
///    Complex(real: 3.0, imaginary: 4.0),
///    Complex(real: 3.0, imaginary: 4.0) ,
///    Complex(real: 3.0, imaginary: 4.0),
///    Complex(real: 3.0, imaginary: 4.0)
///  ])
ArrayComplex arrayComplexConcat(ArrayComplex a, ArrayComplex b) {
  ArrayComplex c = ArrayComplex.empty();
  for (int i = 0; i < a.length; i++) {
    c.add(a[i]);
  }
  for (int i = 0; i < b.length; i++) {
    c.add(b[i]);
  }
  return c;
}
