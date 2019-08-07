import '../../numdart.dart';
import '../array_complex.dart';
import 'array_complex_concat.dart';

///  Add zeros at begging of the array
///  Examples
///  >>> var list = ArrayComplex([
///  >>> Complex(real: 3.0, imaginary: 4.0),
///  >>> Complex(real: 3.0, imaginary: 4.0) ,
///  >>> Complex(real: 3.0, imaginary: 4.0)]);
///  >>> arrayComplexPadStart(list, 2)
///  ArrayComplex([
///    Complex(real: 0.0, imaginary: 0.0),
///    Complex(real: 0.0, imaginary: 0.0),
///    Complex(real: 3.0, imaginary: 4.0),
///    Complex(real: 3.0, imaginary: 4.0),
///    Complex(real: 3.0, imaginary: 4.0)
///  ])
ArrayComplex arrayComplexPadStart(ArrayComplex a, int pad) {
  var aux = ArrayComplex.fixed(pad, initialValue: Complex());
  return arrayComplexConcat(aux, a);
}
