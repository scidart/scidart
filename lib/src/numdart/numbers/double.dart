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
  var mod = pow(10.0, fractionDigits).toDouble();
  return ((val * mod).round().toDouble() / mod);
}

class FloatInfo {
  static double get eps => 2e-16;
}

/// Check if [a] is an Even number after a truncation.
/// - [fractionDigits] : number of decimal digits
bool isEvenDouble(double a, int fractionDigits) {
  var aT = truncate(a, fractionDigits);
  var aTString = aT.toString();
  var last = int.parse(aTString[aTString.length - 1]);
  return last % 2 == 0;
}

/// Check if [a] is an Odd number after a truncation.
/// - [fractionDigits] : number of decimal digits
bool isOddDouble(double a, int fractionDigits) {
  var aT = truncate(a, fractionDigits);
  var aTString = aT.toString();
  var last = int.parse(aTString[aTString.length - 1]);
  return last % 2 != 0;
}
