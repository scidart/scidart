import 'dart:math';

import 'package:scidart/numdart/array/array.dart';

///  Generates a Array with n elements containing non-negative random floating
///  point value uniformly distributed in the range from 0.0, inclusive,
///  to 1.0, exclusive.
///  [n] : length of array
Array randomArray(int n) {
  var rng = Random();
  var l = List.generate(n, (_) => rng.nextDouble());
  return Array(l);
}
