import 'dart:math';

import '../array.dart';

///  Return the index of the first greater element of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> arrayArgMax(n);
///  2
int arrayArgMax(Array a) {
  var el = a.reduce(max);
  return a.indexOf(el);
}
