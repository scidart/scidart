import 'package:scidart/src/numdart/numdart.dart';

///  Return modified Bessel function of order 0 for a number.
///  [x] : double
///  Returns
///  -------
///  y : double
///  bessel function at x point
///  References
///  ----------
///  .. [1] "scipy.special.i0". https://docs.scipy.org/doc/scipy/reference/generated/scipy.special.i0.html. Retrieved 2019-08-06.
///  .. [2] "bessel function". https://en.wikipedia.org/wiki/Bessel_function#Modified_Bessel_functions:_I%CE%B1,_K%CE%B1. Retrieved 2019-08-06.
///  .. [3] "Modified Bessel functions of order (n)". https://stackoverflow.com/questions/8797722/modified-bessel-functions-of-order-n. Retrieved 2019-08-06.
///  Examples
///  --------
///  >>>  besselI0(0);
///  1.0
double besselI0(double x) {
  double answer;
  var ax = x.abs();
  if (ax < 3.75) {
    // polynomial fit
    var y = x / 3.75;
    y *= y;
    answer = 1.0 +
        y *
            (3.5156229 +
                y *
                    (3.0899424 +
                        y *
                            (1.2067492 +
                                y *
                                    (0.2659732 +
                                        y * (0.360768e-1 + y * 0.45813e-2)))));
  } else {
    var y = 3.75 / ax;
    answer = 0.39894228 +
        y *
            (0.1328592e-1 +
                y *
                    (0.225319e-2 +
                        y *
                            (-0.157565e-2 +
                                y *
                                    (0.916281e-2 +
                                        y *
                                            (-0.2057706e-1 +
                                                y *
                                                    (0.2635537e-1 +
                                                        y *
                                                            (-0.1647633e-1 +
                                                                y * 0.392377e-2)))))));
    answer *= (exp(ax) / sqrt(ax));
  }
  return answer;
}
