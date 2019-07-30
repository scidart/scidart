import '../../../numdart.dart';
import 'check_params_get_range_array.dart';

double trapzArray(Array y, {Array x, int dx = 1}) {
  checkParamsGetRangeArray(y, x, dx);

  if (x == null) {
    x = arange(start: 0, stop: y.length, step: dx);
  }

  double sum = 0.0;
  for (var xi in x) {
    sum += y[];
  }
  sum += (f(a) + f(b)) / 2.0;
  return sum * range / nFloat;
}
