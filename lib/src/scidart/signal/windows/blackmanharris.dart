import 'package:scidart/src/numdart/numdart.dart';

import 'general_cosine.dart';

/// Return a minimum 4-term Blackman-Harris window.
///
/// # Parameters
/// - [M] : int
/// Number of points in the output window. If zero or less, an empty
/// array is returned.
/// - [sym] : bool, optional
/// When true (default), generates a symmetric window, for use in filter
/// design.
/// When false, generates a periodic window, for use in spectral analysis.
///
/// # Returns
/// - w : Array
/// The window, with the maximum value normalized to 1 (though the value 1
/// does not appear if `M` is even and `sym` is True).
///
/// # References
/// 1. "scipy.signal.windows.blackmanharris". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.windows.blackmanharris.html#scipy.signal.windows.blackmanharris. Retrieved 2019-07-15.
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
/// import 'package:scidart/scidart/signal/signal.dart';
/// var M = 10;
/// var w = blackmanharris(M);
/// ```
Array blackmanharris(int M, {bool sym = true}) {
  return generalCosine(M, Array([0.35875, 0.48829, 0.14128, 0.01168]), sym: sym);
}