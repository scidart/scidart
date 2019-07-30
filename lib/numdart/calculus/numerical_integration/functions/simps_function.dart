import 'package:scidart/numdart/calculus/numerical_integration/functions/check_params_get_range.dart';

///  Compute the numerical integration of f() using the Simpson's rule.
///  [a] : start interval of the integration
///  [b] : final interval of the integration
///  [n] : number of the points between the interval
///  [f] : function to integrate
double simpsFunction(double a, double b, int n, Function f) {
  double range = checkParamsGetRange(a, b, n);
  double nFloat = n.toDouble();
  double sum1 = f(a + range / (nFloat * 2.0));
  double sum2 = 0.0;
  for (int i = 1; i < n; i++) {
    double x1 = a + range * (i.toDouble() + 0.5) / nFloat;
    sum1 += f(x1);
    double x2 = a + range * i.toDouble() / nFloat;
    sum2 += f(x2);
  }
  return (f(a) + f(b) + sum1 * 4.0 + sum2 * 2.0) * range / (nFloat * 6.0);
}
