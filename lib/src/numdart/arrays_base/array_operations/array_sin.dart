import 'dart:math' as math;

import '../array.dart';

///  Compute the sin for each element of the array
///  Examples
///  --------
///  >>> var n = Array([0.5*pi, pi, (3/2)*pi, 2*pi]);
///  >>> var sinn = arraySin(n);
///  Array([6.123233995736766e-17, -1.0, -1.8369701987210297e-16, 1.0])
Array arraySin(Array a) {
  var c = Array.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = math.sin(a[i]); //fixme change to fast cos in the future
  }
  return c;
}
