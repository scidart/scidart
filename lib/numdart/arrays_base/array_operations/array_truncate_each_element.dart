import 'package:scidart/numdart/numbers/double.dart';

import '../array.dart';

///  Truncate all the numbers of the array
///  Examples
///  --------
///  >>> var n = Array([4.123456789, 4.123456789, 4.123456789]);
///  >>> arrayTruncateEachElement(n, 4);
///  Array([4.1235, 4.1235, 4.1235])
dynamic arrayTruncateEachElement(Array a, int fractionDigits,
    {bool returnNewArray = false}) {
  if (returnNewArray) {
    var b = Array.fixed(a.length);
    for (var i = 0; i < a.length; i++) {
      b[i] = truncate(a[i], fractionDigits);
    }
    return b;
  } else {
    for (var i = 0; i < a.length; i++) {
      a[i] = truncate(a[i], fractionDigits);
    }
  }
}
