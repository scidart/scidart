import 'package:scidart/numdart/calculus/numerical_integration/functions/check_params_get_range.dart';

///  Compute the numerical integration of f() using the trapezoidal rule.
///  [a] : start interval of the integration
///  [b] : final interval of the integration
///  [n] : number of the points between the interval
///  [f] : function to integrate
///  References
///  ----------
///  .. [1] "Numerical integration". https://rosettacode.org/wiki/Numerical_integration#Java. Retrieved 2019-07-31.
///  Examples
///  --------
///  >>> var i = trapzFunction(0, 2*pi, 20, (x) => cos(x));
///  truncate(i, 4);
///  0
double trapzFunction(double a, double b, int n, Function f) {
  double range = checkParamsGetRange(a, b, n);
  double nFloat = n.toDouble();
  double sum = 0.0;
  for (int i = 1; i < n; i++) {
    double x = a + range * i.toDouble() / nFloat;
    sum += f(x);
  }
  sum += (f(a) + f(b)) / 2.0;
  return sum * range / nFloat;
}
