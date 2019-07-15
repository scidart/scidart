import 'package:scidart/numdart/numdart.dart';

import 'general_cosine.dart';

///  Return a flat top window.
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
///  Flat top windows are used for taking accurate measurements of signal
///  amplitude in the frequency domain, with minimal scalloping error from the
///  center of a frequency bin to its edges, compared to others.  This is a
///  5th-order cosine window, with the 5 terms optimized to make the main lobe
///  maximally flat. [1]_
///  References
///  ----------
///  .. [1] "scipy.signal.windows.flattop". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.windows.flattop.html#scipy.signal.windows.flattop. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> import 'package:scidart/scidart/signal/signal.dart';
///  >>> var M = 10;
///  >>> var w = flattop(M);
Array flattop(int M, {bool sym = true}) {
  var a = Array([0.21557895, 0.41663158, 0.277263158, 0.083578947, 0.006947368]);
  return generalCosine(M, a, sym: sym);
}