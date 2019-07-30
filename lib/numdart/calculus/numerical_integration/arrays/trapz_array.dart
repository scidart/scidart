import 'package:scidart/numdart/calculus/numerical_integration/functions/check_params_get_range.dart';

import '../../../numdart.dart';

double trapzFunction(Array y, {Array x, double dx = 1}) {
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
