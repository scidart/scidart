import 'dart:math' as math;

import '../array.dart';

///  Compute the log10 for each element of the array
///  Examples
///  --------
///  >>> var n = Array([0.1, 1, 10, 100]);
///  >>> var log = arrayLog10(n);
///  Array([6.123233995736766e-17, -1.0, -1.8369701987210297e-16, 1.0])
Array arrayLog10(Array a) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] =
        math.log(a[i]) / math.log(10); //fixme change to fast log in the future
  }
  return c;
}
