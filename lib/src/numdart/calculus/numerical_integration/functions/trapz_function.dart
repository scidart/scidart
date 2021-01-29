import 'package:scidart/src/numdart/calculus/numerical_integration/functions/check_params_get_range.dart';

/// Compute the numerical integration of f() using the trapezoidal rule.
/// - [a] : start interval of the integration
/// - [b] : final interval of the integration
/// - [n] : number of the points between the interval
/// - [f] : function to integrate
///
/// # References
/// 1. "Numerical integration". https://rosettacode.org/wiki/Numerical_integration#Java. Retrieved 2019-07-31.
///
/// # Examples
/// ```dart
/// var i = trapzFunction(0, 2*pi, 20, (x) => cos(x));
///
/// print(truncate(i, 4));
///
/// /* output:
/// 0
/// */
/// ```
double trapzFunction(double a, double b, int n, Function f) {
  var range = checkParamsGetRange(a, b, n);
  var nFloat = n.toDouble();
  var sum = 0.0;
  for (var i = 1; i < n; i++) {
    var x = a + range * i.toDouble() / nFloat;
    sum += f(x);
  }
  sum += (f(a) + f(b)) / 2.0;
  return sum * range / nFloat;
}
