import 'package:scidart/src/numdart/arrays_base/array_operations/array_truncate_each_element.dart';

import '../array2d.dart';

///  Trucate all the elements of the array
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
///  >>>   Array([2.123456789, 2.123456789, 2.123456789]),
///  >>>   Array([2.123456789, 2.123456789, 2.123456789])
///  >>> ]);
///  >>> array2dTruncateEachElement(a, 4);
///  Array2d([
///    Array([2.1235, 2.1235, 2.1235]),
///    Array([2.1235, 2.1235, 2.1235]),
///    Array([2.1235, 2.1235, 2.1235])
///  ]);
dynamic array2dTruncateEachElement(Array2d a, int fractionDigits,
    {bool returnNewArray = false}) {
  if (returnNewArray) {
    Array2d b = Array2d.empty();
    for (var elem in a) {
      var tmp =
          arrayTruncateEachElement(elem, fractionDigits, returnNewArray: true);
      b.add(tmp);
    }
    return b;
  } else {
    for (var elem in a) {
      arrayTruncateEachElement(elem, fractionDigits);
    }
  }
}
