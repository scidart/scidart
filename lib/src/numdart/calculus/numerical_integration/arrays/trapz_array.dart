import '../../../numdart.dart';
import 'check_params_get_range_array.dart';

/// Compute the numerical integration of an Array using the trapezoidal rule.
/// - [y] : input array to integrate
/// - [x] : The sample points corresponding to the y values. If x is null,
/// the sample points are assumed to be evenly spaced dx apart. The default is null.
/// - [dx] : The spacing between sample points when x is None. The default is 1.
///
/// # References
/// 1. "doc numpy.trapz". https://docs.scipy.org/doc/numpy/reference/generated/numpy.trapz.html#numpy.trapz. Retrieved 2019-07-31.
/// 2. "numpy.trapz". https://github.com/numpy/numpy/blob/v1.17.0/numpy/lib/function_base.py#L3987-L4075. Retrieved 2019-07-31.
///
/// # Examples
/// ```dart
/// var y = Array([1, 2, 3]);
///
/// print(trapzArray(y));
/// /* output:
/// 4
/// */
/// ```
double trapzArray(Array y, {Array? x, int dx = 1}) {
  checkParamsGetRangeArray(y, x, dx);

  var d;
  if (x != null) {
    d = arrayDiff(x);
  } else {
    d = Array.fixed(y.length - 1, initialValue: dx.toDouble());
  }

  var slice1 = y.getRangeArray(0, y.length - 1);
  var slice2 = y.getRangeArray(1, y.length);

  var ret = arraySum(d * arrayDivisionToScalar(slice1 + slice2, 2.0));

  return ret;
}
