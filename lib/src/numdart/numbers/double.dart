import 'dart:math';

/// Truncate the decimal part of a double number. This function is very useful
/// for compere two double numbers.
/// - [val] : a double value
/// - [fractionDigits] : number of decimal digits
///
/// # References
/// 1. "How do you round a double in Dart to a given degree of precision AFTER the decimal point?". https://stackoverflow.com/a/53500405/6846888. Retrieved 2019-07-15.
///
/// # Examples
/// ```dart
/// print(truncate(1.4747474747474747, 3));
///
/// /* output:
/// 1.475;
/// */
/// ```
double truncate(double val, int fractionDigits) {
  double mod = pow(10.0, fractionDigits); 
  return ((val * mod).round().toDouble() / mod);
}

class FloatInfo {
  static double get eps => 2e-16;
}