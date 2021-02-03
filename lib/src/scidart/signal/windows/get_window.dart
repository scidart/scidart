import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/scidart.dart';

/// Return a window.
///
/// # Parameters
/// - [window] : String, double, or List
/// The type of window to create. See below for more details.
/// - [Nx] : int
/// The number of samples in the window.
/// - [fftbins] : bool, optional
/// If True, create a "periodic" window ready to use with ifftshift
/// and be multiplied by the result of an fft (SEE ALSO fftfreq).
///
/// # Returns
/// - get_window : Array
/// Returns a window of length `Nx` and type `window`
///
/// # Notes
/// - Window types:
/// blackman, hamming, hann, flattop,
/// blackmanharris, nuttall,
/// kaiser (needs beta)
/// If the window requires no parameters, then `window` can be a string.
/// If the window requires parameters, then `window` must be a tuple
/// with the first argument the string name of the window, and the next
/// arguments the needed parameters.
/// If `window` is a floating point number, it is interpreted as the beta
/// parameter of the kaiser window.
/// Each of the window types listed above is also the name of
/// a function that can be called directly to create a window of
/// that type.
///
/// # References
/// 1. "doc scipy.signal.get_window". https://docs.scipy.org/doc/scipy-0.14.0/reference/generated/scipy.signal.get_window.html. Retrieved 2019-07-15.
/// 2. "source code scipy.signal.get_window". https://github.com/scipy/scipy/blob/v0.14.0/scipy/signal/windows.py#L1380. Retrieved 2019-07-15.
///
/// # Examples
/// ```dart
/// print(getWindow(['kaiser', 4.0], 9));
/// print(getWindow('black', 10));
///
/// /* output:
/// Array([ 0.08848053,  0.32578323,  0.63343178,  0.89640418,  1.0, 0.89640418,  0.63343178,  0.32578323,  0.08848053]);
/// Array([-1.38777878e-17, 5.08696327e-02, 2.58000502e-01, 6.30000000e-01, 9.51129866e-01, 9.51129866e-01, 6.30000000e-01, 2.58000502e-01, 5.08696327e-02, -1.38777878e-17]);
/// */
/// ```
Array getWindow(dynamic window, int Nx, {bool fftbins = true}) {
  var sym = !fftbins;
  if (window is List && window[0] is String && window[1] is double) {
    // beta dependent windows
    var win = window[0] as String;
    var arg = window[1];

    if (win == 'kaiser' || win == 'ksr') {
      return kaiser(Nx, arg, sym: sym);
    } else {
      throw FormatException('Window type not found');
    }
  } else if (window is String) {
    // without beta windows
    if (window == 'blackman' || window == 'black' || window == 'blk') {
      return blackman(Nx, sym: sym);
    } else if (window == 'blackmanharris' ||
        window == 'blackharr' ||
        window == 'bkh') {
      return blackmanharris(Nx, sym: sym);
    } else if (window == 'flattop' || window == 'flat' || window == 'flt') {
      return flattop(Nx, sym: sym);
    } else if (window == 'hamming' || window == 'hamm' || window == 'ham') {
      return hamming(Nx, sym: sym);
    } else if (window == 'hanning' || window == 'hann' || window == 'han') {
      return hann(Nx, sym: sym);
    } else if (window == 'nuttall' || window == 'nutl' || window == 'nut') {
      return nuttall(Nx, sym: sym);
    } else {
      throw FormatException('Window type not found');
    }
  } else if (window is double) {
    // kaiser, if dont specified
    return kaiser(Nx, window, sym: sym);
  } else {
    throw FormatException(
        'window need be a String with the name of windows or array where first element is a String with window name and secound is a double with beta');
  }
}
