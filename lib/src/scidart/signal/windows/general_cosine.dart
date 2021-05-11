import 'package:scidart/src/numdart/numdart.dart';

/// Handle small or incorrect window lengths
bool _len_guards(int M) {
  if (M != M || M < 0) {
    throw ('Window length M must be a non-negative integer');
  }
  return M <= 1;
}

/// Extend window by 1 sample if needed for DFT-even symmetry
List<Object> _extend(int M, bool sym) {
  if (!sym) {
    return [M + 1, true];
  } else {
    return [M, false];
  }
}

/// Truncate window by 1 sample if needed for DFT-even symmetry
Array _truncate(Array w, needed) {
  if (needed) {
    return arrayTruncateLast(w);
  } else {
    return w;
  }
}

/// Generic weighted sum of cosine terms window
///
/// # Parameters
/// - [M] : Number of points in the output window
/// - [a] : array_like
/// Sequence of weighting coefficients. This uses the convention of being
/// centered on the origin, so these will typically all be positive
/// numbers, not alternating sign.
/// - [sym] : bool, optional
/// When true (default), generates a symmetric window, for use in filter
/// design.
/// When false, generates a periodic window, for use in spectral analysis.
///
/// # References
/// 1. "Window function". https://en.wikipedia.org/wiki/Window_function#cite_note-28. Retrieved 2019-07-12.
/// 2. "Hann (Hanning) window - MATLAB hann". https://www.mathworks.com/help/signal/ref/hann.html. Retrieved 2019-07-12.
/// 3. "Window functions (scipy.signal.windows)". https://docs.scipy.org/doc/scipy/reference/signal.windows.html. Retrieved 2019-07-12.
///
/// # Examples
/// ```dart
/// // Create a Hann window:
/// // .. math::  w_n = 0.5\; \left[1 - \cos \left ( \frac{2 \pi n}{N} \right) \right]
/// import 'package:scidart/src/numdart/numdart.dart';
/// import 'package:scidart/scidart/signal/signal.dart';
///
/// var alpha = 0.5;
/// var M = 10;
/// var w = generalCosine(M, Array([alpha, 1.0 - alpha]));
/// ```
Array generalCosine(int M, Array a, {bool sym = true}) {
  if (_len_guards(M)) {
    return ones(M);
  }

  var ext = _extend(M, sym);
  var MExt = ext[0] as int;
  var needsTrunc = ext[1];

  var fac = linspace(-pi, pi, num: MExt);
  var w = zeros(MExt);
  for (var k = 0; k < a.length; k++) {
    w += arrayMultiplyToScalar(arrayCos(arrayMultiplyToScalar(fac, k)), a[k]);
  }

  return _truncate(w, needsTrunc);
}
