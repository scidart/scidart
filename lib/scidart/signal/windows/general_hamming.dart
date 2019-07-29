import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/signal/windows/general_cosine.dart';

///  Return a generalized Hamming window.
///  The generalized Hamming window is constructed by multiplying a rectangular
///  window by one period of a cosine function [1]_.
///  Parameters
///  ----------
///  [M] : int
///      Number of points in the output window. If zero or less, an empty
///      array is returned.
///  [alpha] : float
///      The window coefficient, :math:`\alpha`
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
///  The generalized Hamming window is defined as
///  .. math:: w(n) = \alpha - \left(1 - \alpha\right) \cos\left(\frac{2\pi{n}}{M-1}\right)
///            \qquad 0 \leq n \leq M-1
///  Both the common Hamming window and Hann window are special cases of the
///  generalized Hamming window with :math:`\alpha` = 0.54 and :math:`\alpha` =
///  0.5, respectively [2]_.
///  See Also
///  --------
///  hamming, hann
///  Examples
///  --------
///  The Sentinel-1A/B Instrument Processing Facility uses generalized Hamming
///  windows in the processing of spaceborne Synthetic Aperture Radar (SAR)
///  data [3]_. The facility uses various values for the :math:`\alpha`
///  parameter based on operating mode of the SAR instrument. Some common
///  :math:`\alpha` values include 0.75, 0.7 and 0.52 [4]_. As an example, we
///  plot these different windows.
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> import 'package:scidart/scidart/signal/signal.dart';
///  >>> from scipy.fftpack import fft, fftshift
///  >>> var alpha = 0.54;
///  >>> var M = 10;
///  >>> var w = generalHamming(M, alpha);
///  References
///  ----------
///  .. [1] DSPRelated, "Generalized Hamming Window Family",
///         https:///www.dsprelated.com/freebooks/sasp/Generalized_Hamming_Window_Family.html
///  .. [2] Wikipedia, "Window function",
///         https:///en.wikipedia.org/wiki/Window_function
///  .. [3] Riccardo Piantanida ESA, "Sentinel-1 Level 1 Detailed Algorithm
///         Definition",
///         https:///sentinel.esa.int/documents/247904/1877131/Sentinel-1-Level-1-Detailed-Algorithm-Definition
///  .. [4] Matthieu Bourbigot ESA, "Sentinel-1 Product Definition",
///         https:///sentinel.esa.int/documents/247904/1877131/Sentinel-1-Product-Definition
///  .. [5] "Window functions (scipy.signal.windows)". https://docs.scipy.org/doc/scipy/reference/signal.windows.html. Retrieved 2019-07-12.
Array generalHamming(int M, double alpha, {bool sym = true}) {
  return generalCosine(M, Array([alpha, 1.0 - alpha]), sym: sym);
}