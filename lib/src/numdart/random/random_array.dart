import 'dart:math';

import 'package:scidart/src/numdart/arrays_base/array.dart';

/// Generates an Array with n elements containing non-negative random floating
/// point value uniformly distributed in the range from 0.0, inclusive,
/// to 1.0, exclusive.
/// - [n] : length of array
///
/// # References
/// 1. "how do i generate random numbers in dart". https://stackoverflow.com/questions/11674820/how-do-i-generate-random-numbers-in-dart. Retrieved 2019-07-26.
/// 2. "numpy.random.rand". https://docs.scipy.org/doc/numpy/reference/generated/numpy.random.rand.html. Retrieved 2019-07-26.
///
/// # Examples
/// ```dart
/// var x = randomArray(20);
/// ```
Array randomArray(int n) {
  var rng = Random();
  var l = List.generate(n, (_) => rng.nextDouble());
  return Array(l);
}
