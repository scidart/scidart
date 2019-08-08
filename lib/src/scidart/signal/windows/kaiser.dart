import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/special/bessel/array_bessel_i0.dart';
import 'package:scidart/src/scidart/special/bessel/bessel_i0.dart';

///  Return a Kaiser window.
///  The Kaiser window is a taper formed by using a Bessel function.
///  Parameters
///  ----------
///  [M] : int
///  Number of points in the output window. If zero or less, an empty
///  array is returned.
///  [beta] : float
///  Shape parameter, determines trade-off between main-lobe width and
///  side lobe level. As beta gets large, the window narrows.
///  [sym] : bool, optional
///  When True (default), generates a symmetric window, for use in filter
///  design.
///  When False, generates a periodic window, for use in spectral analysis.
///  Returns
///  -------
///  w : Array
///  The window, with the maximum value normalized to 1 (though the value 1
///  does not appear if `M` is even and `sym` is True).
///  References
///  ----------
///  .. [1] "doc scipy.signal.windows.kaiser". https://docs.scipy.org/doc/scipy-1.0.0/reference/generated/scipy.signal.kaiser.html. Retrieved 2019-07-15.
///  .. [2] "scipy.signal.windows.kaiser". https://github.com/scipy/scipy/blob/v1.0.0/scipy/signal/windows.py#L1041-L1156. Retrieved 2019-07-15.
///  .. [3] "Kaiser window". https://en.wikipedia.org/wiki/Kaiser_window. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> kaiser(51, 14);
///  Array([0.0, 0.000030289318777624507, 0.00004239621466381779, 0.000051380818964122076, 0.00005869490140397769, 0.00006490568309490965, 0.00007030616828562361, 0.00007507143433951038, 0.00007931605488406376, 0.00008311983051443031, 0.00008654091079321288, 0.00008962313100358323, 0.0000924004076541195, 0.00009489951744979998, 0.0000971419314382709, 0.00009914506860507969, 0.00010092317755426455, 0.00010248797129609238, 0.00010384909295185544, 0.00010501446237187035, 0.00010599053665954447, 0.00010678250685060226, 0.00010739444599705794, 0.00010782941920703497, 0.00010808956293663774, 0.00010817613849151608, 0.00010808956293663774, 0.00010782941920703497, 0.00010739444599705794, 0.00010678250685060226, 0.00010599053665954447, 0.00010501446237187035, 0.00010384909295185544, 0.00010248797129609238, 0.00010092317755426455, 0.00009914506860507969, 0.0000971419314382709, 0.00009489951744979998, 0.0000924004076541195, 0.00008962313100358323, 0.00008654091079321288, 0.00008311983051443031, 0.00007931605488406376, 0.00007507143433951038, 0.00007030616828562361, 0.00006490568309490965, 0.00005869490140397769, 0.000051380818964122076, 0.00004239621466381779, 0.000030289318777624507, 0.0])
Array kaiser(int M, double beta, {bool sym = true}) {
  if (M < 1) {
    return Array([]);
  }
  if (M == 1) {
    return ones(1);
  }
  var odd = M % 2;
  if (!sym && odd != 0) {
    M = M + 1;
  }
  var n = arange(start: 0, stop: M);
  var alpha = (M - 1) / 2.0;

  var one = ones(M);

//  w = (special.i0(beta * np.sqrt(1 - ((n - alpha) / alpha) ** 2.0)) / special.i0(beta))


  var den = arraySqrt(one -
      arrayPow(arrayDivisionToScalar(arraySubToScalar(n, alpha), alpha), 2.0));
  den = arrayMultiplyToScalar(den, beta);

  var w = arrayDivisionToScalar(arrayBesselI0(den), besselI0(beta));

  if (!sym && odd != 0) {
    w = arrayTruncateLast(w);
  }

  return w;
}
