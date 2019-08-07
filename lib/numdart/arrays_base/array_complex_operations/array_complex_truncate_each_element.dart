import 'package:scidart/numdart/arrays_base/array_complex.dart';
import 'package:scidart/numdart/numbers/complex_operations/complex_truncate.dart';

///  Truncate all the numbers of the array
///  Examples
///  --------
///  >>> var n = Array([4.123456789, 4.123456789, 4.123456789]);
///  >>> arrayTruncateEachElement(n, 4);
///  >>> n
///  Array([4.1235, 4.1235, 4.1235])
dynamic arrayComplexTruncateEachElement(ArrayComplex a, int fractionDigits,
    {bool returnNewArray = false}) {
  if (returnNewArray) {
    var b = ArrayComplex.fixed(a.length);
    for (var i = 0; i < a.length; i++) {
      b[i] = complexTruncate(a[i], fractionDigits);
    }
    return b;
  } else {
    for (var i = 0; i < a.length; i++) {
      a[i] = complexTruncate(a[i], fractionDigits);
    }
  }
}
