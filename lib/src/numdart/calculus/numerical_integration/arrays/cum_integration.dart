import 'package:scidart/src/numdart/numdart.dart';

/// Compute the numerical accumulative integration of an Array using the trapezoidal rule.
/// - [y] : input array to integrate
/// - [x] : The sample points corresponding to the y values. If x is null,
/// the sample points are assumed to be evenly spaced dx apart. The default is null.
/// - [dx] : The spacing between sample points when x is None. The default is 1.
/// - [initial] : optional. If given, uses this value as the first value in the returned result.
/// Typically this value should be 0. Default is null, which means no value
/// at x[0] is returned and return has one element less than y along the axis of integration.
///
/// # References
/// 1. "doc scipy.integrate.cumtrapz". https://docs.scipy.org/doc/scipy-0.18.1/reference/generated/scipy.integrate.cumtrapz.html. Retrieved 2019-08-01.
/// 2. "scipy.integrate.cumtrapz". https://github.com/scipy/scipy/blob/v0.18.1/scipy/integrate/quadrature.py#L206-L295. Retrieved 2019-08-01.
///
/// # Examples
/// ```dart
/// var y = Array([1, 2, 3]);
///
/// print(cumIntegration(y));
/// ```
Array cumIntegration(Array y, {Array? x, int dx = 1, double? initial}) {
  checkParamsGetRangeArray(y, x, dx);

  var d;
  if (x != null) {
    d = arrayDiff(x);
  } else {
    d = Array.fixed(y.length - 1, initialValue: dx.toDouble());
  }

  var slice1 = y.getRangeArray(0, y.length - 1);
  var slice2 = y.getRangeArray(1, y.length);

  var ret = arrayCumSum(d * arrayDivisionToScalar(slice1 + slice2, 2.0));

  if (initial != null) {
    ret = arrayConcat([arrayMultiplyToScalar(ones(1), initial), ret]);
  }

  return ret;
}
