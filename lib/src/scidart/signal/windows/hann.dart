import 'package:scidart/src/numdart/numdart.dart';

import 'general_hamming.dart';

///  Return a Hann window.
///  The Hann window is a taper formed by using a raised cosine or sine-squared
///  with ends that touch zero.
///  Parameters
///  ----------
///  [M] : int
///      Number of points in the output window. If zero or less, an empty
///      array is returned.
///  [sym] : bool, optional
///      When True (default), generates a symmetric window, for use in filter
///      design.
///      When False, generates a periodic window, for use in spectral analysis.
///  Returns
///  -------
///  w : ndarray
///      The window, with the maximum value normalized to 1 (though the value 1
///      does not appear if `M` is even and `sym` is True).
///  Notes
///  -----
///  The Hann window is defined as
///  .. math::  w(n) = 0.5 - 0.5 \cos\left(\frac{2\pi{n}}{M-1}\right)
///             \qquad 0 \leq n \leq M-1
///  The window was named for Julius von Hann, an Austrian meteorologist. It is
///  also known as the Cosine Bell. It is sometimes erroneously referred to as
///  the "Hanning" window, from the use of "hann" as a verb in the original
///  paper and confusion with the very similar Hamming window.
///  Most references to the Hann window come from the signal processing
///  literature, where it is used as one of many windowing functions for
///  smoothing values.  It is also known as an apodization (which means
///  "removing the foot", i.e. smoothing discontinuities at the beginning
///  and end of the sampled signal) or tapering function.
///  References
///  ----------
///  .. [1] Blackman, R.B. and Tukey, J.W., (1958) The measurement of power
///         spectra, Dover Publications, New York.
///  .. [2] E.R. Kanasewich, "Time Sequence Analysis in Geophysics",
///         The University of Alberta Press, 1975, pp. 106-108.
///  .. [3] Wikipedia, "Window function",
///         https:///en.wikipedia.org/wiki/Window_function
///  .. [4] W.H. Press,  B.P. Flannery, S.A. Teukolsky, and W.T. Vetterling,
///         "Numerical Recipes", Cambridge University Press, 1986, page 425.
///  Examples
///  --------
///  Plot the window and its frequency response:
///  >>> var M = 10;
///  >>> var w = hann(M, sym: false);
///  >>> print(w);
Array hann(int M, {bool sym = true}) {
  return generalHamming(M, 0.5, sym: sym);
}