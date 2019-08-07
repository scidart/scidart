import '../array_complex.dart';

///  Return a Array without the last element
///  Examples
///  --------
///  >>> var list = ArrayComplex([
///  >>> Complex(real: 3.0, imaginary: 4.0),
///  >>> Complex(real: 3.0, imaginary: 4.0) ,
///  >>> Complex(real: 3.0, imaginary: 4.0)]);
///  >>> list.cos()
///  ArrayComplex([Complex(real: -27.034945603074224, imaginary: -3.8511533348117775), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775), Complex(real: -27.034945603074224, imaginary: -3.8511533348117775)])
ArrayComplex arrayComplexTruncateLast(ArrayComplex a) {
  var c = ArrayComplex.fixed(a.length - 1);
  for (int i = 0; i < c.length; i++) {
    c[i] = a[i];
  }
  return c;
}
