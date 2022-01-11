import 'dart:math';

import 'package:scidart/src/numdart/arrays_base/array_complex.dart';
import 'package:scidart/src/numdart/numbers/complex.dart';

/// Generates an ArrayComplex with n elements containing non-negative random floating
/// point value uniformly distributed complex numbers in the range
/// from 0.0, inclusive, to 1.0, exclusive.
/// - [n] : length of array
///
/// # Examples
/// ```dart
/// var x = randomArrayComplex(20);
/// ```
ArrayComplex randomArrayComplex(int n) {
  var rng = Random();
  var l =
      List.generate(n, (_) => Complex.ri(rng.nextDouble(), rng.nextDouble()));
  return ArrayComplex(l);
}
