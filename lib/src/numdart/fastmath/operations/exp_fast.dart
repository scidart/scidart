import 'package:scidart/src/numdart/fastmath/tables/exp_frac_table_a.dart';
import 'package:scidart/src/numdart/fastmath/tables/exp_frac_table_b.dart';
import 'package:scidart/src/numdart/fastmath/tables/exp_int_table_a.dart';
import 'package:scidart/src/numdart/fastmath/tables/exp_int_table_b.dart';
import 'package:scidart/src/numdart/fastmath/tables/exp_int_table_max_index.dart';

/// Internal helper method for exponential function.
///
/// - [x] is the original argument of the exponential function.
/// - [extra] bits of precision on input (To Be Confirmed).
/// - [hiPrec] extra bits of precision on output (To Be Confirmed)
double expFast(double x, [double extra = 0.0, List<double>? hiPrec]) {
  double intPartA;
  double intPartB;
  int intVal;

  // Lookup exp(floor(x)).
  // intPartA will have the upper 22 bits, intPartB will have the lower
  // 52 bits.
  if (x < 0.0) {
    intVal = -x.toInt();

    if (intVal > 746) {
      if (hiPrec != null) {
        hiPrec[0] = 0.0;
        hiPrec[1] = 0.0;
      }
      return 0.0;
    }

    if (intVal > 709) {
      // This will produce a subnormal output
      final result =
          expFast(x + 40.19140625, extra, hiPrec) / 285040095144011776.0;
      if (hiPrec != null) {
        hiPrec[0] /= 285040095144011776.0;
        hiPrec[1] /= 285040095144011776.0;
      }
      return result;
    }

    if (intVal == 709) {
      // exp(1.494140625) is nearly a machine number...
      final result =
          expFast(x + 1.494140625, extra, hiPrec) / 4.455505956692756620;
      if (hiPrec != null) {
        hiPrec[0] /= 4.455505956692756620;
        hiPrec[1] /= 4.455505956692756620;
      }
      return result;
    }

    intVal++;

    intPartA = EXP_INT_TABLE_A[EXP_INT_TABLE_MAX_INDEX - intVal];
    intPartB = EXP_INT_TABLE_B[EXP_INT_TABLE_MAX_INDEX - intVal];

    intVal = -intVal;
  } else {
    if (x == double.infinity) {
      if (hiPrec != null) {
        hiPrec[0] = double.infinity;
        hiPrec[1] = 0.0;
      }
      return double.infinity;
    }

    intVal = x.toInt();

    if (intVal > 709) {
      if (hiPrec != null) {
        hiPrec[0] = double.infinity;
        hiPrec[1] = 0.0;
      }
      return double.infinity;
    }

    intPartA = EXP_INT_TABLE_A[EXP_INT_TABLE_MAX_INDEX + intVal];
    intPartB = EXP_INT_TABLE_B[EXP_INT_TABLE_MAX_INDEX + intVal];
  }

  // Get the fractional part of x, find the greatest multiple of 2^-10 less than
  // x and look up the exp function of it.
  // fracPartA will have the upper 22 bits, fracPartB the lower 52 bits.
  final intFrac = ((x - intVal) * 1024.0).toInt();
  final fracPartA = EXP_FRAC_TABLE_A[intFrac];
  final fracPartB = EXP_FRAC_TABLE_B[intFrac];

  // epsilon is the difference in x from the nearest multiple of 2^-10.  It
  // has a value in the range 0 <= epsilon < 2^-10.
  // Do the subtraction from x as the last step to avoid possible loss of percison.
  final epsilon = x - (intVal + intFrac / 1024.0);

  // Compute z = exp(epsilon) - 1.0 via a minimax polynomial.  z has
  // full double precision (52 bits).  Since z < 2^-10, we will have
  // 62 bits of precision when combined with the contant 1.  This will be
  // used in the last addition below to get proper rounding.

  // Remez generated polynomial.  Converges on the interval [0, 2^-10], error
  // is less than 0.5 ULP
  var z = 0.04168701738764507;
  z = z * epsilon + 0.1666666505023083;
  z = z * epsilon + 0.5000000000042687;
  z = z * epsilon + 1.0;
  z = z * epsilon + -3.940510424527919E-20;

  // Compute (intPartA+intPartB) * (fracPartA+fracPartB) by binomial
  // expansion.
  // tempA is exact since intPartA and intPartB only have 22 bits each.
  // tempB will have 52 bits of precision.
  var tempA = intPartA * fracPartA;
  var tempB =
      intPartA * fracPartB + intPartB * fracPartA + intPartB * fracPartB;

  // Compute the result.  (1+z)(tempA+tempB).  Order of operations is
  // important.  For accuracy add by increasing size.  tempA is exact and
  // much larger than the others.  If there are extra bits specified from the
  // pow() function, use them.
  final tempC = tempB + tempA;
  double result;
  if (extra != 0.0) {
    result = tempC * extra * z + tempC * extra + tempC * z + tempB + tempA;
  } else {
    result = tempC * z + tempB + tempA;
  }

  if (hiPrec != null) {
    // If requesting high precision
    hiPrec[0] = tempA;
    hiPrec[1] = tempC * extra * z + tempC * extra + tempC * z + tempB;
  }

  return result;
}
