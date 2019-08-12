import 'dart:math' as math;

import 'package:scidart/src/numdart/fastmath/operations/exp_fast.dart';
import 'package:scidart/src/numdart/fastmath/tables/hex_40000000.dart';
import 'package:scidart/src/numdart/fastmath/tables/log_max_value.dart';

/// Compute the hyperbolic cosine of a number.
double cosh(double x) {
  if (x != x) {
    return x;
  }

  // cosh[z] = (exp(z) + exp(-z))/2

  // for numbers with magnitude 20 or so,
  // exp(-z) can be ignored in comparison with exp(z)

  if (x > 20) {
    if (x >= LOG_MAX_VALUE) {
      // Avoid overflow (MATH-905).
      final double t = math.exp(0.5 * x);
      return (0.5 * t) * t;
    } else {
      return 0.5 * expFast(x);
    }
  } else if (x < -20) {
    if (x <= -LOG_MAX_VALUE) {
      // Avoid overflow (MATH-905).
      final double t = expFast(-0.5 * x);
      return (0.5 * t) * t;
    } else {
      return 0.5 * expFast(-x);
    }
  }

  final hiPrec = List<double>(2);
  if (x < 0.0) {
    x = -x;
  }
  expFast(x, 0.0, hiPrec);

  double ya = hiPrec[0] + hiPrec[1];
  double yb = -(ya - hiPrec[0] - hiPrec[1]);

  double temp = ya * HEX_40000000;
  double yaa = ya + temp - temp;
  double yab = ya - yaa;

  // recip = 1/y
  double recip = 1.0 / ya;
  temp = recip * HEX_40000000;
  double recipa = recip + temp - temp;
  double recipb = recip - recipa;

  // Correct for rounding in division
  recipb +=
      (1.0 - yaa * recipa - yaa * recipb - yab * recipa - yab * recipb) * recip;
  // Account for yb
  recipb += -yb * recip * recip;

  // y = y + 1/y
  temp = ya + recipa;
  yb += -(temp - ya - recipa);
  ya = temp;
  temp = ya + recipb;
  yb += -(temp - ya - recipb);
  ya = temp;

  double result = ya + yb;
  result *= 0.5;
  return result;
}
