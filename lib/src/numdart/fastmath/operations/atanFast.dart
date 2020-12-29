import 'dart:math' as math;

import 'package:scidart/src/numdart/fastmath/operations/copySign.dart';
import 'package:scidart/src/numdart/fastmath/tables/eights.dart';
import 'package:scidart/src/numdart/fastmath/tables/fractions.dart';
import 'package:scidart/src/numdart/fastmath/tables/hex_40000000.dart';
import 'package:scidart/src/numdart/fastmath/tables/tagent_table_b.dart';
import 'package:scidart/src/numdart/fastmath/tables/tangent_table_a.dart';

/// Internal helper function to compute arctangent.
///
/// [xa] number from which arctangent is requested.
/// [xb] extra bits for x (may be 0.0).
/// [leftPlane] if true, result angle must be put in the left half plane.
/// Returns `atan(xa + xb)` (or angle shifted by `PI` if leftPlane is true)
double atanFast(double xa, [double xb = 0.0, bool leftPlane = false]) {
  if (xa == 0.0) {
    // Matches +/- 0.0; return correct sign
    return leftPlane ? copySign(math.pi, xa) : xa;
  }

  bool negate;
  if (xa < 0) {
    // negative
    xa = -xa;
    xb = -xb;
    negate = true;
  } else {
    negate = false;
  }

  if (xa > 1.633123935319537E16) {
    // Very large input
    return (negate != leftPlane) ? (-math.pi * F_1_2) : (math.pi * F_1_2);
  }

  /* Estimate the closest tabulated arctan value, compute eps = xa-tangentTable */
  int idx;
  if (xa < 1) {
    idx = (((-1.7168146928204136 * xa * xa + 8.0) * xa) + 0.5).toInt();
  } else {
    final oneOverXa = 1 / xa;
    idx = (-((-1.7168146928204136 * oneOverXa * oneOverXa + 8.0) * oneOverXa) +
            13.07)
        .toInt();
  }

  final ttA = TANGENT_TABLE_A[idx];
  final ttB = TANGENT_TABLE_B[idx];

  var epsA = xa - ttA;
  var epsB = -(epsA - xa + ttA);
  epsB += xb - ttB;

  var temp = epsA + epsB;
  epsB = -(temp - epsA - epsB);
  epsA = temp;

  /* Compute eps = eps / (1.0 + xa*tangent) */
  temp = xa * HEX_40000000;
  var ya = xa + temp - temp;
  var yb = xb + xa - ya;
  xa = ya;
  xb += yb;

  //if (idx > 8 || idx == 0)
  if (idx == 0) {
    /// If the slope of the arctan is gentle enough (< 0.45), this approximation will suffice
    //double denom = 1.0 / (1.0 + xa*tangentTableA[idx] + xb*tangentTableA[idx] + xa*tangentTableB[idx] + xb*tangentTableB[idx]);
    final denom = 1.0 / (1.0 + (xa + xb) * (ttA + ttB));
    //double denom = 1.0 / (1.0 + xa*tangentTableA[idx]);
    ya = epsA * denom;
    yb = epsB * denom;
  } else {
    var temp2 = xa * ttA;
    var za = 1.0 + temp2;
    var zb = -(za - 1.0 - temp2);
    temp2 = xb * ttA + xa * ttB;
    temp = za + temp2;
    zb += -(temp - za - temp2);
    za = temp;

    zb += xb * ttB;
    ya = epsA / za;

    temp = ya * HEX_40000000;
    final yaa = (ya + temp) - temp;
    final yab = ya - yaa;

    temp = za * HEX_40000000;
    final zaa = (za + temp) - temp;
    final zab = za - zaa;

    /* Correct for rounding in division */
    yb = (epsA - yaa * zaa - yaa * zab - yab * zaa - yab * zab) / za;

    yb += -epsA * zb / za / za;
    yb += epsB / za;
  }

  epsA = ya;
  epsB = yb;

  // Evaluate polynomial
  final epsA2 = epsA * epsA;

  /*
  yb = -0.09001346640161823;
  yb = yb * epsA2 + 0.11110718400605211;
  yb = yb * epsA2 + -0.1428571349122913;
  yb = yb * epsA2 + 0.19999999999273194;
  yb = yb * epsA2 + -0.33333333333333093;
  yb = yb * epsA2 * epsA;
  */

  yb = 0.07490822288864472;
  yb = yb * epsA2 - 0.09088450866185192;
  yb = yb * epsA2 + 0.11111095942313305;
  yb = yb * epsA2 - 0.1428571423679182;
  yb = yb * epsA2 + 0.19999999999923582;
  yb = yb * epsA2 - 0.33333333333333287;
  yb = yb * epsA2 * epsA;

  ya = epsA;

  temp = ya + yb;
  yb = -(temp - ya - yb);
  ya = temp;

  /* Add in effect of epsB.   atan'(x) = 1/(1+x^2) */
  yb += epsB / (1.0 + epsA * epsA);

  final eighths = EIGHTHS[idx];

  //result = yb + eighths[idx] + ya;
  var za = eighths + ya;
  var zb = -(za - eighths - ya);
  temp = za + yb;
  zb += -(temp - za - yb);
  za = temp;

  var result = za + zb;

  if (leftPlane) {
    // Result is in the left plane
    final resultb = -(result - za - zb);
    final pia = 1.5707963267948966 * 2;
    final pib = 6.123233995736766E-17 * 2;

    za = pia - result;
    zb = -(za - pia + result);
    zb += pib - resultb;

    result = za + zb;
  }

  if (negate != leftPlane) {
    result = -result;
  }

  return result;
}
