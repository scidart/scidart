import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/signal/windows/get_window.dart';

/// FIR filter design using the window method.
/// This function computes the coefficients of a finite impulse response
/// filter.  The filter will have linear phase; it will be Type I if
/// `numtaps` is odd and Type II if `numtaps` is even.
/// Type II filters always have zero response at the Nyquist frequency, so a
/// ValueError exception is raised if firwin is called with `numtaps` even and
/// having a passband whose right end is at the Nyquist frequency.
///
/// # Parameters
/// - [numtaps] : int
/// Length of the filter (number of coefficients, i.e. the filter
/// order + 1).  `numtaps` must be odd if a passband includes the
/// Nyquist frequency.
/// - [cutoff] : Array
/// Cutoff frequency of filter (expressed in the same units as `fs`)
/// OR an array of cutoff frequencies (that is, band edges). In the
/// latter case, the frequencies in `cutoff` should be positive and
/// monotonically increasing between 0 and `fs/2`.  The values 0 and
/// `fs/2` must not be included in `cutoff`.
/// - [width] : double or None, optional
/// If `width` is not None, then assume it is the approximate width
/// of the transition region (expressed in the same units as `fs`)
/// for use in Kaiser FIR filter design.  In this case, the `window`
/// argument is ignored.
/// - [window] : string or tuple of string and parameter values, optional
/// Desired window to use. See `scipy.signal.get_window` for a list
/// of windows and required parameters.
/// - [pass_zero] : {true, false, 'bandpass', 'lowpass', 'highpass', 'bandstop'}, optional
/// If True, the gain at the frequency 0 (i.e. the "DC gain") is 1.
/// If False, the DC gain is 0. Can also be a string argument for the
/// desired filter type (equivalent to ``btype`` in IIR design functions).
/// .. versionadded:: 1.3.0
/// Support for string arguments.
/// - [scale] : bool, optional
/// Set to True to scale the coefficients so that the frequency
/// response is exactly unity at a certain frequency.
/// That frequency is either:
///  - 0 (DC) if the first passband starts at 0 (i.e. pass_zero
///  is True)
///  - `fs/2` (the Nyquist frequency) if the first passband ends at
///  fs/2` (i.e the filter is a single band highpass filter);
///  center of first passband otherwise
/// - [nyq] : double, optional
/// *Deprecated.  Use `fs` instead.*  This is the Nyquist frequency.
/// Each frequency in `cutoff` must be between 0 and `nyq`. Default
/// is 1.
/// - [fs] : float, optional
/// The sampling frequency of the signal.  Each frequency in `cutoff`
/// must be between 0 and ``fs/2``.  Default is 2.
///
/// # Returns
/// - h : Array
/// Coefficients of length `numtaps` FIR filter.
///
/// # Raises
/// - [FormatException] If any value in `cutoff` is less than or equal to 0 or greater
/// than or equal to ``fs/2``, if the values in `cutoff` are not strictly
/// monotonically increasing, or if `numtaps` is even but a passband
/// includes the Nyquist frequency.
///
/// # References
/// 1. "doc scipy.signal.firwin". https://docs.scipy.org/doc/scipy/reference/generated/scipy.signal.firwin.html#scipy.signal.firwin. Retrieved 2019-08-06.
/// 2. "source code scipy.signal.firwin". https://github.com/scipy/scipy/blob/v1.3.0/scipy/signal/fir_filter_design.py#L264-L482. Retrieved 2019-08-06.
/// 3. "fir filter design". https://scipy-cookbook.readthedocs.io/items/FIRFilter.html. Retrieved 2019-08-06.
///
/// # Examples
/// ```dart
/// var numtaps = 3;
/// var f = 0.1;
/// print(firwin(numtaps, Array([f])));
///
/// /* output:
/// Array([0.06799017,  0.86401967,  0.06799017]);
/// */
/// ```
dynamic firwin(int numtaps, Array cutoff,
    {double? width,
    dynamic window = 'hamming',
    dynamic pass_zero = true,
    bool scale = true,
    double? nyq,
    double? fs}) {
  nyq = 0.5 * _getFs(fs, nyq);
  cutoff = arrayDivisionToScalar(cutoff, nyq);

  // Check for invalid input.
  if (cutoff.isEmpty) {
    throw FormatException('At least one cutoff frequency must be given.');
  }
  if (arrayMin(cutoff) <= 0 || arrayMax(cutoff) >= 1) {
    throw FormatException(
        'Invalid cutoff frequency: frequencies must be greater than 0 and less than fs/2.');
  }
  if (arrayDiff(cutoff).any((i) => i <= 0)) {
    throw FormatException(
        'Invalid cutoff frequencies: the frequencies must be strictly increasing.');
  }

  if (width != null) {
    // A width was given. Find the beta parameter of the Kaiser window
    // and set `window`. This overrides the value of `window` passed in.
    var atten = kaiserAtten(numtaps, width / nyq);
    var beta = kaiserBeta(atten);
    window = ['kaiser', beta];
  }

  if (pass_zero is String) {
    if (pass_zero == 'bandstop' || pass_zero == 'lowpass') {
      if (pass_zero == 'lowpass') {
        if (cutoff.length != 1) {
          throw FormatException(
              'cutoff must have one element if pass_zero=="lowpass", got $cutoff');
        } else if (cutoff.length <= 1) {
          throw FormatException(
              'cutoff must have at least two elements if pass_zero=="bandstop", got $cutoff');
        }
        pass_zero = true;
      } else if (pass_zero == 'bandpass' || pass_zero == 'highpass') {
        if (pass_zero == 'highpass') {
          if (cutoff.length != 1) {
            throw FormatException(
                'cutoff must have one element if pass_zero=="highpass", got ${cutoff.length}');
          }
        } else if (cutoff.length <= 1) {
          throw FormatException(
              'cutoff must have at least two elements if pass_zero=="bandpass", got $cutoff');
        }
        pass_zero = false;
      } else {
        throw FormatException(
            'pass_zero must be True, False, "bandpass", "lowpass", "highpass", or "bandstop", got $pass_zero');
      }
    }
  }

  // ensure bool-like
  if (!(pass_zero is bool)) {
    throw FormatException(
        "pass_zero is not a bool, please, insert: true, false, 'bandpass', 'lowpass', 'highpass', 'bandstop'");
  }

  var pass_nyquist = intToBool(cutoff.length & 1 ^ boolToInt(pass_zero));

  if (pass_nyquist && numtaps % 2 == 0) {
    throw FormatException(
        'A filter with an even number of coefficients must have zero response at the Nyquist frequency.');
  }

  // Insert 0 and/or 1 at the ends of cutoff so that the length of cutoff
  // is even, and each pair in cutoff corresponds to passband.
  if (pass_zero) {
    cutoff = arrayConcat([
      Array([0.0]),
      cutoff
    ]);
  }
  if (pass_nyquist) {
    cutoff = arrayConcat([
      cutoff,
      Array([1.0])
    ]);
  }

  // `bands` is a 2D array; each row gives the left and right edges of
  // a passband.
  var bands = arrayReshapeToMatrix(cutoff, 2);

  // Build up the coefficients.
  var alpha = 0.5 * (numtaps - 1);
  var m = arraySubToScalar(arange(start: 0, stop: numtaps), alpha);
  var h = Array.fixed(m.length, initialValue: 0);
  for (var j = 0; j < bands.row; j++) {
    // lr[0] - left; lr[1] - right
    var left = bands[j][0];
    var right = bands[j][1];
    h += arrayMultiplyToScalar(
        arraySinc(arrayMultiplyToScalar(m, right)), right);
    h -= arrayMultiplyToScalar(arraySinc(arrayMultiplyToScalar(m, left)), left);
  }

  // Get and apply the window function.
  var win = getWindow(window, numtaps, fftbins: false);
  h *= win;

  // Now handle scaling if desired.
  if (scale) {
    // Get the first passband.
    var left = bands[0][0];
    var right = bands[0][1];
    var scale_frequency;
    if (left == 0) {
      scale_frequency = 0.0;
    } else if (right == 1) {
      scale_frequency = 1.0;
    } else {
      scale_frequency = 0.5 * (left + right);
    }
    var c = arrayCos(arrayMultiplyToScalar(m, pi * scale_frequency));
    var s = arraySum(h * c);
    h = arrayDivisionToScalar(h, s);
  }

  return h;
}

/// Utility for replacing the argument 'nyq' (with default 1) with 'fs'.
double _getFs(double? fs, double? nyq) {
  if (fs != null && nyq != null) {
    throw FormatException("Values cannot be given for both 'nyq' and 'fs'.");
  }

  var fsReturn = fs ?? 0;
  if (nyq == null && fs == null) {
    fsReturn = 2;
  } else if (nyq != null) {
    fsReturn = 2 * nyq;
  }
  return fsReturn;
}

/// Compute the attenuation of a Kaiser FIR filter.
/// Given the number of taps `N` and the transition width `width`, compute the
/// attenuation `a` in dB, given by Kaiser's formula:
///  a = 2.285 * (N - 1) * pi * width + 7.95
///
/// # Parameters
/// - [numtaps] : The number of taps in the FIR filter.
/// - [width] : The desired width of the transition region between passband and
/// stopband (or, in general, at any discontinuity) for the filter,
/// expressed as a fraction of the Nyquist frequency.
///
/// # Returns
/// - a : The attenuation of the ripple, in dB.
///
/// # See Also
/// - kaiserord, kaiser_beta
///
/// # Examples
/// ```dart
/// // Suppose we want to design a FIR filter using the Kaiser window method
/// // that will have 211 taps and a transition width of 9 Hz for a signal that
/// // is sampled at 480 Hz.  Expressed as a fraction of the Nyquist frequency,
/// // the width is 9/(0.5*480) = 0.0375.  The approximate attenuation (in dB)
/// // is computed as follows:
/// print(kaiser_atten(211, 0.0375));
///
/// /* output:
/// 64.48099630593983
/// */
/// ```
double kaiserAtten(int numtaps, double width) {
  var a = 2.285 * (numtaps - 1) * pi * width + 7.95;
  return a;
}

/// Compute the Kaiser parameter `beta`, given the attenuation `a`.
///
/// # Parameters
/// - a : The desired attenuation in the stopband and maximum ripple in
/// the passband, in dB.  This should be a *positive* number.
///
/// # Returns
/// - beta : The `beta` parameter to be used in the formula for a Kaiser window.
///
/// # References
/// 1. Oppenheim, Schafer, "Discrete-Time Signal Processing", p.475-476.
///
/// # Examples
/// ```dart
/// // Suppose we want to design a lowpass filter, with 65 dB attenuation
/// // in the stop band.  The Kaiser window parameter to be used in the
/// // window method is computed by `kaiser_beta(65)`:
/// print(kaiser_beta(65));
/// /* output:
/// 6.20426
/// */
/// ```
double kaiserBeta(double a) {
  var beta;
  if (a > 50) {
    beta = 0.1102 * (a - 8.7);
  } else if (a > 21) {
    beta = 0.5842 * pow(a - 21, 0.4) + 0.07886 * (a - 21);
  } else {
    beta = 0.0;
  }
  return beta;
}
