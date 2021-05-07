import 'package:scidart/src/numdart/arrays_base/arrays_base.dart';

import 'check_params_get_range_array.dart';

/// Integrate y(x) using samples along the given axis and the composite
/// Simpson's rule.  If x is None, spacing of dx is assumed.
/// If there are an even number of samples, N, then there are an odd
/// number of intervals (N-1), but Simpson's rule requires an even number
/// of intervals.  The parameter 'even' controls how this is handled.
///
/// # Parameters
/// - [y] : Array to be integrated.
/// - [x] : Optional. If given, the points at which `y` is sampled.
/// - [dx] : Optional. Spacing of integration points along axis of `y`.
/// Only used when `x` is null(not informed). Default is 1.
/// - [even] : Even {avg, first, last}, optional
/// \[avg\] : Average two results:1) use the first N-2 intervals with
/// a trapezoidal rule on the last interval and 2) use the last
/// N-2 intervals with a trapezoidal rule on the first interval.
/// \[first\] : Use Simpson's rule for the first N-2 intervals with
/// a trapezoidal rule on the last interval.
/// \[last\] : Use Simpson's rule for the last N-2 intervals with a
/// trapezoidal rule on the first interval.
///
/// # References
/// 1. "numpy.simps". https://github.com/scipy/scipy/blob/v1.3.0/scipy/integrate/quadrature.py#L384-L506. Retrieved 2019-07-31.
/// 2. "doc numpy.simps". https://docs.scipy.org/doc/scipy/reference/generated/scipy.integrate.simps.html#scipy.integrate.simps. Retrieved 2019-07-31.
///
/// # Examples
/// ```dart
/// var x = arange(start: 0, stop: 10);
/// var y = arange(start: 0, stop: 10);
///
/// print(simpsArray(y, x: x));
///
/// /* output:
/// 40.5
/// */
/// ```
double simpsArray(Array y, {Array? x, int dx = 1, Even even = Even.last}) {
  checkParamsGetRangeArray(y, x, dx);
  var result;
  var N = y.length;

  if (N % 2 == 0) {
    var val = 0.0;
    result = 0.0;

    // Compute using Simpson's rule on first intervals
    if (even == Even.avg || even == Even.first) {
      var yslice1 = y[y.length - 1];
      var yslice2 = y[y.length - 2];

      var last_dx;
      if (x != null) {
        var xslice1 = x[x.length - 1];
        var xslice2 = x[x.length - 2];
        last_dx = xslice1 - xslice2;
      }
      val += 0.5 * last_dx * (yslice1 + yslice2);
      result = _basicSimps(y, 0, N - 3, x, dx);
    }

    // Compute using Simpson's rule on last set of intervals
    if (even == Even.avg || even == Even.last) {
      var yslice1 = y[0];
      var yslice2 = y[1];

      var first_dx;
      if (x != null) {
        var xslice1 = x[0];
        var xslice2 = x[1];
        first_dx = xslice2 - xslice1;
      }
      val += 0.5 * first_dx * (yslice2 + yslice1);
      result += _basicSimps(y, 1, N - 2, x, dx);
    }

    if (even == Even.avg) {
      val /= 2.0;
      result /= 2.0;
    }

    result = result + val;
  } else {
    result = _basicSimps(y, 0, N - 2, x, dx);
  }

  return result;
}

enum Even { avg, first, last }

double _basicSimps(Array y, int start, int stop, Array? x, int dx) {
  var result;

  var step = 2;

  var slice0 = y.getRangeArray(start, stop, step: step);
  var slice1 = y.getRangeArray(start + 1, stop + 1, step: step);
  var slice2 = y.getRangeArray(start + 2, stop + 2, step: step);

  if (x == null) {
    // Even spaced Simpson's rule.
    result = arraySum(arrayMultiplyToScalar(
        slice0 + arrayMultiplyToScalar(slice1, 4) + slice2, (dx / 3.0)));
  } else {
    // Account for possibly different spacings.
    // Simpson's rule changes a bit.
    var h = arrayDiff(x);
    var h0 = h.getRangeArray(start, stop, step: step);
    var h1 = h.getRangeArray(start + 1, stop + 1, step: step);
    var hsum = h0 + h1;
    var hprod = h0 * h1;
    var h0divh1 = h0 / h1;
    var tmp = arrayDivisionToScalar(hsum, 6.0) *
        (slice0 *
                (Array.fixed(h0divh1.length, initialValue: 2) -
                    Array.fixed(h0divh1.length, initialValue: 1.0) / h0divh1) +
            slice1 * hsum * hsum / hprod +
            slice2 * (Array.fixed(h0divh1.length, initialValue: 2) - h0divh1));
    result = arraySum(tmp);
  }
  return result;
}
