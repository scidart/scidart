import 'package:scidart/src/numdart/fastmath/operations/exp_fast.dart';
import 'package:scidart/src/numdart/fastmath/operations/expm1.dart';
import 'package:scidart/src/numdart/fastmath/tables/hex_40000000.dart';
import 'package:scidart/src/numdart/fastmath/tables/log_max_value.dart';

/// Compute the hyperbolic sine of a number.
double sinh(double x) {
  var negate = false;
  if (x != x) {
    return x;
  }

  // sinh[z] = (exp(z) - exp(-z) / 2

  // for values of z larger than about 20,
  // exp(-z) can be ignored in comparison with exp(z)

  if (x > 20) {
    if (x >= LOG_MAX_VALUE) {
      // Avoid overflow (MATH-905).
      final t = expFast(0.5 * x);
      return (0.5 * t) * t;
    } else {
      return 0.5 * expFast(x);
    }
  } else if (x < -20) {
    if (x <= -LOG_MAX_VALUE) {
      // Avoid overflow (MATH-905).
      final t = expFast(-0.5 * x);
      return (-0.5 * t) * t;
    } else {
      return -0.5 * expFast(-x);
    }
  }

  if (x == 0) {
    return x;
  }

  if (x < 0.0) {
    x = -x;
    negate = true;
  }

  double result;

  if (x > 0.25) {
    final hiPrec = List<double>(2);
    expFast(x, 0.0, hiPrec);

    var ya = hiPrec[0] + hiPrec[1];
    var yb = -(ya - hiPrec[0] - hiPrec[1]);

    var temp = ya * HEX_40000000;
    var yaa = ya + temp - temp;
    var yab = ya - yaa;

    // recip = 1/y
    var recip = 1.0 / ya;
    temp = recip * HEX_40000000;
    var recipa = recip + temp - temp;
    var recipb = recip - recipa;

    // Correct for rounding in division
    recipb +=
        (1.0 - yaa * recipa - yaa * recipb - yab * recipa - yab * recipb) *
            recip;
    // Account for yb
    recipb += -yb * recip * recip;

    recipa = -recipa;
    recipb = -recipb;

    // y = y + 1/y
    temp = ya + recipa;
    yb += -(temp - ya - recipa);
    ya = temp;
    temp = ya + recipb;
    yb += -(temp - ya - recipb);
    ya = temp;

    result = ya + yb;
    result *= 0.5;
  } else {
    final hiPrec = List<double>(2);
    expm1(x, hiPrecOut: hiPrec);

    var ya = hiPrec[0] + hiPrec[1];
    var yb = -(ya - hiPrec[0] - hiPrec[1]);

    /* Compute expm1(-x) = -expm1(x) / (expm1(x) + 1) */
    var denom = 1.0 + ya;
    var denomr = 1.0 / denom;
    var denomb = -(denom - 1.0 - ya) + yb;
    var ratio = ya * denomr;
    var temp = ratio * HEX_40000000;
    var ra = ratio + temp - temp;
    var rb = ratio - ra;

    temp = denom * HEX_40000000;
    var za = denom + temp - temp;
    var zb = denom - za;

    rb += (ya - za * ra - za * rb - zb * ra - zb * rb) * denomr;

    // Adjust for yb
    rb += yb * denomr; // numerator
    rb += -ya * denomb * denomr * denomr; // denominator

    // y = y - 1/y
    temp = ya + ra;
    yb += -(temp - ya - ra);
    ya = temp;
    temp = ya + rb;
    yb += -(temp - ya - rb);
    ya = temp;

    result = ya + yb;
    result *= 0.5;
  }

  if (negate) {
    result = -result;
  }

  return result;
}
