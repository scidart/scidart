import 'dart:math' as math;

import 'package:scidart/src/numdart/fastmath/operations/atanFast.dart';
import 'package:scidart/src/numdart/fastmath/operations/copySign.dart';
import 'package:scidart/src/numdart/fastmath/tables/fractions.dart';

/// Two arguments arctangent function
///
/// [y] ordinate. [x] abscissa.
/// Returns phase angle of point (x,y) between `-PI` and `PI`.
double atan2Fast(double y, double x) {
  if (x != x || y != y) {
    return double.nan;
  }

  if (y == 0) {
    final double result = x * y;
    final double invx = 1.0 / x;
    final double invy = 1.0 / y;

    if (invx == 0) {
      // X is infinite
      if (x > 0) {
        return y; // return +/- 0.0
      } else {
        return copySign(math.pi, y);
      }
    }

    if (x < 0 || invx < 0) {
      if (y < 0 || invy < 0) {
        return -math.pi;
      } else {
        return math.pi;
      }
    } else {
      return result;
    }
  }

  // y cannot now be zero

  if (y == double.infinity) {
    if (x == double.infinity) {
      return math.pi * F_1_4;
    }

    if (x == double.negativeInfinity) {
      return math.pi * F_3_4;
    }

    return math.pi * F_1_2;
  }

  if (y == double.negativeInfinity) {
    if (x == double.infinity) {
      return -math.pi * F_1_4;
    }

    if (x == double.negativeInfinity) {
      return -math.pi * F_3_4;
    }

    return -math.pi * F_1_2;
  }

  if (x == double.infinity) {
    if (y > 0 || 1 / y > 0) {
      return 0.0;
    }

    if (y < 0 || 1 / y < 0) {
      return -0.0;
    }
  }

  if (x == double.negativeInfinity) {
    if (y > 0.0 || 1 / y > 0.0) {
      return math.pi;
    }

    if (y < 0 || 1 / y < 0) {
      return -math.pi;
    }
  }

  // Neither y nor x can be infinite or NAN here

  if (x == 0) {
    if (y > 0 || 1 / y > 0) {
      return math.pi * F_1_2;
    }

    if (y < 0 || 1 / y < 0) {
      return -math.pi * F_1_2;
    }
  }

  // Compute ratio r = y/x
  final double r = y / x;
  if (r.isInfinite) {
    // bypass calculations that can create NaN
    return atanFast(r, 0.0, x < 0);
  }

  double ra = r; // TODO(rwl): doubleHighPart(r);
  double rb = r - ra;

  // Split x
  final double xa = x; // TODO(rwl): doubleHighPart(x);
  final double xb = x - xa;

  rb += (y - ra * xa - ra * xb - rb * xa - rb * xb) / x;

  final double temp = ra + rb;
  rb = -(temp - ra - rb);
  ra = temp;

  if (ra == 0) {
    // Fix up the sign so atan works correctly
    ra = copySign(0.0, y);
  }

  // Call atan
  final double result = atanFast(ra, rb, x < 0);

  return result;
}
