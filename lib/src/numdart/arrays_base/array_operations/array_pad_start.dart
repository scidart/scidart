import '../array.dart';
import 'array_concat.dart';

/// Add zeros at begging of the array
///
/// # Examples
/// ```dart
/// var list = Array([1,2,3]);
///
/// print(arrayPadStart(list, 2));
///
/// /* output:
/// Array([0, 0, 1, 2, 3])
/// */
/// ```
Array arrayPadStart(Array a, int pad) {
  var aux = Array.fixed(pad, initialValue: 0);
  return arrayConcat([aux, a]);
}
