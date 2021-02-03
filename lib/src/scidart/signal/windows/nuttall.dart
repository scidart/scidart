import 'package:scidart/src/numdart/numdart.dart';

import 'general_cosine.dart';

/// Return a minimum 4-term Blackman-Harris window according to Nuttall.
/// This variation is called "Nuttall4c" by Heinzel. [1]_
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
/// 1. "scipy.signal.windows.nuttall". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.windows.nuttall.html#scipy.signal.windows.nuttall. Retrieved 2019-07-15.
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
/// import 'package:scidart/scidart/signal/signal.dart';
/// var M = 10;
/// var w = nuttall(M);
/// ```
Array nuttall(int M, {bool sym = true}) {
  return generalCosine(M, Array([0.3635819, 0.4891775, 0.1365995, 0.0106411]),
      sym: sym);
}
