import 'dart:math';

/// Calculate the hypotenuse with pythagorean theorem
/// - [x] : cathetus X
/// - [y] : cathetus Y
///
/// # Examples
/// ```dart
/// print(truncate(1.4747474747474747, 3));
/// /* output:
/// 1.475;
/// */
/// ```
double hypotenuse(double x, double y) {
  return sqrt(pow(x, 2) + pow(y, 2));
}