import 'package:scidart/src/numdart/numdart.dart';

import 'erf.dart';

/// Return the error function for each element of Array.
/// - [a] : Array
///
/// # Returns
/// - b : Array
///
/// # Examples
/// ```dart
/// print(arrayErf(Array([0.0, 0.5])));
///
/// /* output:
/// Array([0.0, 0.5204998778130465])
/// */
/// ```
Array arrayErf(Array a) {
  return Array(a.map(erf).toList());
}

/// Return the complementary error function for each element of Array.
/// - [a] : Array
///
/// # Returns
/// - b : Array
///
/// # Examples
/// ```dart
/// print(arrayErfc(Array([0.0, 3.0])));
///
/// /* output:
/// Array([1.0, 0.000022090496998585438])
/// */
/// ```
Array arrayErfc(Array a) {
  return Array(a.map(erfc).toList());
}
