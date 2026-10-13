import 'dart:math' as math;

/// Return the error function of [x].
/// - [x] : double
///
/// # Returns
/// - y : double
/// `2 / sqrt(pi) * integral from 0 to x of exp(-t^2) dt`
///
/// # References
/// 1. "scipy.special.erf". https://docs.scipy.org/doc/scipy/reference/generated/scipy.special.erf.html. Retrieved 2026-10-13.
/// 2. W. J. Cody, "Rational Chebyshev approximations for the error function", Mathematics of Computation 23 (1969), 631-637.
/// 3. "CALERF". https://www.netlib.org/specfun/erf. Retrieved 2026-10-13.
///
/// # Examples
/// ```dart
/// print(erf(0.5));
///
/// /* output:
/// 0.5204998778130465
/// */
/// ```
double erf(double x) => _calerf(x, _Kind.erf);

/// Return the complementary error function of [x], `1 - erf(x)`, without the
/// loss of precision of the subtraction for large [x].
/// - [x] : double
///
/// # Returns
/// - y : double
///
/// # References
/// 1. "scipy.special.erfc". https://docs.scipy.org/doc/scipy/reference/generated/scipy.special.erfc.html. Retrieved 2026-10-13.
/// 2. W. J. Cody, "Rational Chebyshev approximations for the error function", Mathematics of Computation 23 (1969), 631-637.
///
/// # Examples
/// ```dart
/// print(erfc(3.0));
///
/// /* output:
/// 0.000022090496998585438
/// */
/// ```
double erfc(double x) => _calerf(x, _Kind.erfc);

enum _Kind { erf, erfc }

const _a = [
  3.16112374387056560e00,
  1.13864154151050156e02,
  3.77485237685302021e02,
  3.20937758913846947e03,
  1.85777706184603153e-1,
];
const _b = [
  2.36012909523441209e01,
  2.44024637934444173e02,
  1.28261652607737228e03,
  2.84423683343917062e03,
];
const _c = [
  5.64188496988670089e-1,
  8.88314979438837594e00,
  6.61191906371416295e01,
  2.98635138197400131e02,
  8.81952221241769090e02,
  1.71204761263407058e03,
  2.05107837782607147e03,
  1.23033935479799725e03,
  2.15311535474403846e-8,
];
const _d = [
  1.57449261107098347e01,
  1.17693950891312499e02,
  5.37181101862009858e02,
  1.62138957456669019e03,
  3.29079923573345963e03,
  4.36261909014324716e03,
  3.43936767414372164e03,
  1.23033935480374942e03,
];
const _p = [
  3.05326634961232344e-1,
  3.60344899949804439e-1,
  1.25781726111229246e-1,
  1.60837851487422766e-2,
  6.58749161529837803e-4,
  1.63153871373020978e-2,
];
const _q = [
  2.56852019228982242e00,
  1.87295284992346725e00,
  5.27905102951428412e-1,
  6.05183413124413191e-2,
  2.33520497626869185e-3,
];
const _oneOverSqrtPi = 5.6418958354775628695e-1;
const _threshold = 0.46875;
const _xSmall = 1.11e-16;
const _xBig = 26.543;

double _calerf(double x, _Kind kind) {
  if (x.isNaN) return double.nan;
  var y = x.abs();
  double result;

  if (y <= _threshold) {
    var ysq = y > _xSmall ? y * y : 0.0;
    var xnum = _a[4] * ysq;
    var xden = ysq;
    for (var i = 0; i < 3; i++) {
      xnum = (xnum + _a[i]) * ysq;
      xden = (xden + _b[i]) * ysq;
    }
    result = x * (xnum + _a[3]) / (xden + _b[3]);
    return kind == _Kind.erf ? result : 1.0 - result;
  }

  // erfc(|x|) for |x| > threshold
  if (y <= 4.0) {
    var xnum = _c[8] * y;
    var xden = y;
    for (var i = 0; i < 7; i++) {
      xnum = (xnum + _c[i]) * y;
      xden = (xden + _d[i]) * y;
    }
    result = (xnum + _c[7]) / (xden + _d[7]);
    result *= _expMinusSquare(y);
  } else if (y >= _xBig) {
    result = 0.0;
  } else {
    var ysq = 1.0 / (y * y);
    var xnum = _p[5] * ysq;
    var xden = ysq;
    for (var i = 0; i < 4; i++) {
      xnum = (xnum + _p[i]) * ysq;
      xden = (xden + _q[i]) * ysq;
    }
    result = ysq * (xnum + _p[4]) / (xden + _q[4]);
    result = (_oneOverSqrtPi - result) / y;
    result *= _expMinusSquare(y);
  }

  if (kind == _Kind.erf) {
    result = (0.5 - result) + 0.5;
    return x < 0 ? -result : result;
  }
  return x < 0 ? 2.0 - result : result;
}

/// exp(-y^2) split in two factors to keep the precision of y^2.
double _expMinusSquare(double y) {
  var ysq = (y * 16.0).truncateToDouble() / 16.0;
  var del = (y - ysq) * (y + ysq);
  return math.exp(-ysq * ysq) * math.exp(-del);
}
