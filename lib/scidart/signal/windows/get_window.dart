import 'package:scidart/numdart/numdart.dart';

///  Return a window.
///  Parameters
///  ----------
///  window : string, float, or tuple
///      The type of window to create. See below for more details.
///  Nx : int
///      The number of samples in the window.
///  fftbins : bool, optional
///      If True, create a "periodic" window ready to use with ifftshift
///      and be multiplied by the result of an fft (SEE ALSO fftfreq).
///  Returns
///  -------
///  get_window : ndarray
///      Returns a window of length `Nx` and type `window`
///  Notes
///  -----
///  Window types:
///      boxcar, triang, blackman, hamming, hann, bartlett, flattop,
///      parzen, bohman, blackmanharris, nuttall, barthann,
///      kaiser (needs beta), gaussian (needs std),
///      general_gaussian (needs power, width),
///      slepian (needs width), chebwin (needs attenuation)
///  If the window requires no parameters, then `window` can be a string.
///  If the window requires parameters, then `window` must be a tuple
///  with the first argument the string name of the window, and the next
///  arguments the needed parameters.
///  If `window` is a floating point number, it is interpreted as the beta
///  parameter of the kaiser window.
///  Each of the window types listed above is also the name of
///  a function that can be called directly to create a window of
///  that type.
///  Examples
///  --------
Array get_window(dynamic window, int Nx, {bool fftbins = true}) {
  var sym = !fftbins;
}
