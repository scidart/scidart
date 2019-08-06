import 'package:scidart/numdart/numdart.dart';

import 'bessel_i0.dart';

///  Return modified Bessel function of order 0 for each element of Array.
///  [a] : Array
///  Returns
///  -------
///  [b] : Array
///  Examples
///  --------
Array arrayBesselI0(Array a) {
  var b = a.copy();

  b.forEach((i) => besselI0(i));

  return b;
}
