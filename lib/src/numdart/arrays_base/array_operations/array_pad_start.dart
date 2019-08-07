import '../array.dart';
import 'array_concat.dart';

///  Add zeros at begging of the array
///  Examples
///  >>> var list = Array([1,2,3]);
///  >>> arrayPadStart(list, 2)
///  Array([0, 0, 1, 2, 3])
Array arrayPadStart(Array a, int pad) {
  var aux = Array.fixed(pad, initialValue: 0);
  return arrayConcat(aux, a);
}
