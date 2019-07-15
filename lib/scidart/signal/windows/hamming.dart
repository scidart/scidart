import 'package:scidart/numdart/numdart.dart';

import 'general_hamming.dart';

///  Return a Hamming window.
///  The Hamming window is a taper formed by using a raised cosine with
///  non-zero endpoints, optimized to minimize the nearest side lobe.
///  Parameters
///  ----------
///  [M] : int
///  Number of points in the output window. If zero or less, an empty
///  array is returned.
///  [sym] : bool, optional
///  When true (default), generates a symmetric window, for use in filter
///  design.
///  When false, generates a periodic window, for use in spectral analysis.
///  Returns
///  -------
///  w : Array
///  The window, with the maximum value normalized to 1 (though the value 1
///  does not appear if `M` is even and `sym` is True).
///  Notes
///  -----
///  The Hamming window is defined as
///  .. math::  w(n) = 0.54 - 0.46 \cos\left(\frac{2\pi{n}}{M-1}\right)
///  \qquad 0 \leq n \leq M-1
///  The Hamming was named for R. W. Hamming, an associate of J. W. Tukey and
///  is described in Blackman and Tukey. It was recommended for smoothing the
///  truncated autocovariance function in the time domain.
///  Most references to the Hamming window come from the signal processing
///  literature, where it is used as one of many windowing functions for
///  smoothing values.  It is also known as an apodization (which means
///  "removing the foot", i.e. smoothing discontinuities at the beginning
///  and end of the sampled signal) or tapering function.
///  References
///  ----------
///  .. [1] "scipy.signal.windows.hamming". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.windows.hamming.html#scipy.signal.windows.hamming. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> import 'package:scidart/scidart/signal/signal.dart';
///  >>> var M = 10;
///  >>> var w = hamming(M);
Array hamming(int M, {bool sym = true}) {
  return generalHamming(M, 0.54, sym: sym);
}