import 'package:scidart/src/numdart/arrays_base/array_operations/array_truncate_each_element.dart';

import '../array2d.dart';

/// # array2dTruncateEachElement
/// Truncate all the elements of the array
///
/// ## Examples
/// ```dart
/// var a = Array2d([
///   Array([2.123456789, 2.123456789, 2.123456789]),
///   Array([2.123456789, 2.123456789, 2.123456789]),
///   Array([2.123456789, 2.123456789, 2.123456789])
/// ]);
///
/// print(array2dTruncateEachElement(a, 4));
///
/// /* expected output:
/// Array2d([
///   Array([2.1235, 2.1235, 2.1235]),
///   Array([2.1235, 2.1235, 2.1235]),
///   Array([2.1235, 2.1235, 2.1235])
/// ]);
/// */
/// ```
dynamic array2dTruncateEachElement(Array2d a, int fractionDigits,
    {bool returnNewArray = false}) {
  if (returnNewArray) {
    var b = Array2d.empty();
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
