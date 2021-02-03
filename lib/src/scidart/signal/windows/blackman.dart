import 'package:scidart/src/numdart/numdart.dart';

import 'general_cosine.dart';

/// Return a Blackman window.
/// The Blackman window is a taper formed by using the first three terms of
/// a summation of cosines. It was designed to have close to the minimal
/// leakage possible.  It is close to optimal, only slightly worse than a
/// Kaiser window.
///
/// # Parameters
/// - [M] : int
/// Number of points in the output window. If zero or less, an empty
/// array is returned.
/// - [sym] : bool, optional
/// When true (default), generates a symmetric window, for use in filter
/// design.
/// When False, generates a periodic window, for use in spectral analysis.
///
/// # Returns
/// - w : Array
/// The window, with the maximum value normalized to 1 (though the value 1
/// does not appear if `M` is even and `sym` is True).
///
/// # Notes
/// The Blackman window is defined as
/// .. math::  w(n) = 0.42 - 0.5 \cos(2\pi n/M) + 0.08 \cos(4\pi n/M)
/// The "exact Blackman" window was designed to null out the third and fourth
/// sidelobes, but has discontinuities at the boundaries, resulting in a
/// 6 dB/oct fall-off.  This window is an approximation of the "exact" window,
/// which does not null the sidelobes as well, but is smooth at the edges,
/// improving the fall-off rate to 18 dB/oct. [3]_
/// Most references to the Blackman window come from the signal processing
/// literature, where it is used as one of many windowing functions for
/// smoothing values.  It is also known as an apodization (which means
/// "removing the foot", i.e. smoothing discontinuities at the beginning
/// and end of the sampled signal) or tapering function. It is known as a
/// "near optimal" tapering function, almost as good (by some measures)
/// as the Kaiser window.
///
/// # References
/// 1. "scipy.signal.windows.blackman". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.windows.blackman.html#scipy.signal.windows.blackman. Retrieved 2019-07-15.
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
/// import 'package:scidart/scidart/signal/signal.dart';
/// var M = 10;
/// var w = blackman(M);
/// ```
Array blackman(int M, {bool sym = true}) {
  return generalCosine(M, Array([0.42, 0.50, 0.08]), sym: sym);
}
