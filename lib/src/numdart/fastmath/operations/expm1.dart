import 'package:scidart/src/numdart/fastmath/operations/exp_fast.dart';
import 'package:scidart/src/numdart/fastmath/tables/exp_frac_table_a.dart';
import 'package:scidart/src/numdart/fastmath/tables/exp_frac_table_b.dart';
import 'package:scidart/src/numdart/fastmath/tables/hex_40000000.dart';

/// Compute `exp(x) - 1`.
double expm1(double x, {List<double>? hiPrecOut}) {
  if (x != x || x == 0.0) {
    // NaN or zero
    return x;
  }

  if (x <= -1.0 || x >= 1.0) {
    // If not between +/- 1.0
    //return exp(x) - 1.0;
    final hiPrec = List<double>.filled(2, 0.0);
    expFast(x, 0.0, hiPrec);
    if (x > 0.0) {
      return -1.0 + hiPrec[0] + hiPrec[1];
    } else {
      final ra = -1.0 + hiPrec[0];
      var rb = -(ra + 1.0 - hiPrec[0]);
      rb += hiPrec[1];
      return ra + rb;
    }
  }

  double baseA;
  double baseB;
  double epsilon;
  var negative = false;

  if (x < 0.0) {
    x = -x;
    negative = true;
  }

  {
    var intFrac = (x * 1024.0).toInt();
    var tempA = EXP_FRAC_TABLE_A[intFrac] - 1.0;
    var tempB = EXP_FRAC_TABLE_B[intFrac];

    var temp = tempA + tempB;
    tempB = -(temp - tempA - tempB);
    tempA = temp;

    temp = tempA * HEX_40000000;
    baseA = tempA + temp - temp;
    baseB = tempB + (tempA - baseA);

    epsilon = x - intFrac / 1024.0;
  }

  /// Compute expm1(epsilon)
  var zb = 0.008336750013465571;
  zb = zb * epsilon + 0.041666663879186654;
  zb = zb * epsilon + 0.16666666666745392;
  zb = zb * epsilon + 0.49999999999999994;
  zb *= epsilon;
  zb *= epsilon;

  var za = epsilon;
  var temp = za + zb;
  zb = -(temp - za - zb);
  za = temp;

  temp = za * HEX_40000000;
  temp = za + temp - temp;
  zb += za - temp;
  za = temp;

  /// Combine the parts.   `expm1(a+b) = expm1(a) + expm1(b) + expm1(a)*expm1(b)`
  var ya = za * baseA;
  //double yb = za*baseB + zb*baseA + zb*baseB;
  temp = ya + za * baseB;
  var yb = -(temp - ya - za * baseB);
  ya = temp;

  temp = ya + zb * baseA;
  yb += -(temp - ya - zb * baseA);
  ya = temp;

  temp = ya + zb * baseB;
  yb += -(temp - ya - zb * baseB);
  ya = temp;

  //ya = ya + za + baseA;
  //yb = yb + zb + baseB;
  temp = ya + baseA;
  yb += -(temp - baseA - ya);
  ya = temp;

  temp = ya + za;
  //yb += (ya > za) ? -(temp - ya - za) : -(temp - za - ya);
  yb += -(temp - ya - za);
  ya = temp;

  temp = ya + baseB;
  //yb += (ya > baseB) ? -(temp - ya - baseB) : -(temp - baseB - ya);
  yb += -(temp - ya - baseB);
  ya = temp;

  temp = ya + zb;
  //yb += (ya > zb) ? -(temp - ya - zb) : -(temp - zb - ya);
  yb += -(temp - ya - zb);
  ya = temp;

  if (negative) {
    /// Compute `expm1(-x) = -expm1(x) / (expm1(x) + 1)`
    var denom = 1.0 + ya;
    var denomr = 1.0 / denom;
    var denomb = -(denom - 1.0 - ya) + yb;
    var ratio = ya * denomr;
    temp = ratio * HEX_40000000;
    final ra = ratio + temp - temp;
    var rb = ratio - ra;

    temp = denom * HEX_40000000;
    za = denom + temp - temp;
    zb = denom - za;

    rb += (ya - za * ra - za * rb - zb * ra - zb * rb) * denomr;

    // f(x) = x/1+x
    // Compute f'(x)
    // Product rule:  d(uv) = du*v + u*dv
    // Chain rule:  d(f(g(x)) = f'(g(x))*f(g'(x))
    // d(1/x) = -1/(x*x)
    // d(1/1+x) = -1/( (1+x)^2) *  1 =  -1/((1+x)*(1+x))
    // d(x/1+x) = -x/((1+x)(1+x)) + 1/1+x = 1 / ((1+x)(1+x))

    // Adjust for yb
    rb += yb * denomr; // numerator
    rb += -ya * denomb * denomr * denomr; // denominator

    // negate
    ya = -ra;
    yb = -rb;
  }

  if (hiPrecOut != null) {
    hiPrecOut[0] = ya;
    hiPrecOut[1] = yb;
  }

  return ya + yb;
}
