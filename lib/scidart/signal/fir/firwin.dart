import 'package:scidart/numdart/numdart.dart';

dynamic firwin(int numtaps, Array cutoff,
    {double width,
    String window = 'hamming',
    bool pass_zero = true,
    bool scale = true,
    double nyq,
    double fs}) {
  nyq = 0.5 * _getFs(fs, nyq);
  cutoff = arrayDivisionToScalar(cutoff, nyq);

  // Check for invalid input.
  if (cutoff.isEmpty) {
    throw FormatException("At least one cutoff frequency must be given.");
  }
  if (arrayMin(cutoff) <= 0 || arrayMax(cutoff) >= 1) {
    throw FormatException(
        "Invalid cutoff frequency: frequencies must be greater than 0 and less than fs/2.");
  }
  if (arrayMin(arrayDiff(cutoff)) <= 0) {
    throw FormatException(
        "Invalid cutoff frequencies: the frequencies must be strictly increasing.");
  }

  var atten, beta;
  if (width != null) {
    // A width was given. Find the beta parameter of the Kaiser window
    // and set `window`. This overrides the value of `window` passed in.
    atten = kaiserAtten(numtaps, width / nyq);
    beta = kaiserBeta(atten);
    window = 'kaiser';
  }
}

/// Utility for replacing the argument 'nyq' (with default 1) with 'fs'.
double _getFs(double fs, double nyq) {
  if (nyq == null && fs == null) {
    fs = 2;
  } else if (nyq != null) {
    if (fs != null) {
      throw FormatException("Values cannot be given for both 'nyq' and 'fs'.");
    }
    fs = 2 * nyq;
  }
  return fs;
}

///  Compute the attenuation of a Kaiser FIR filter.
///  Given the number of taps `N` and the transition width `width`, compute the
///  attenuation `a` in dB, given by Kaiser's formula:
///      a = 2.285 * (N - 1) * pi * width + 7.95
///  Parameters
///  ----------
///  [numtaps] : The number of taps in the FIR filter.
///  [width] : The desired width of the transition region between passband and
///      stopband (or, in general, at any discontinuity) for the filter,
///      expressed as a fraction of the Nyquist frequency.
///  Returns
///  -------
///  a : The attenuation of the ripple, in dB.
///  See Also
///  --------
///  kaiserord, kaiser_beta
///  Examples
///  --------
///  Suppose we want to design a FIR filter using the Kaiser window method
///  that will have 211 taps and a transition width of 9 Hz for a signal that
///  is sampled at 480 Hz.  Expressed as a fraction of the Nyquist frequency,
///  the width is 9/(0.5*480) = 0.0375.  The approximate attenuation (in dB)
///  is computed as follows:
///  >>> from scipy.signal import kaiser_atten
///  >>> kaiser_atten(211, 0.0375)
///  64.48099630593983
double kaiserAtten(int numtaps, double width) {
  var a = 2.285 * (numtaps - 1) * pi * width + 7.95;
  return a;
}

///  Compute the Kaiser parameter `beta`, given the attenuation `a`.
///  Parameters
///  ----------
///  a : The desired attenuation in the stopband and maximum ripple in
///      the passband, in dB.  This should be a *positive* number.
///  Returns
///  -------
///  beta : The `beta` parameter to be used in the formula for a Kaiser window.
///  References
///  ----------
///  Oppenheim, Schafer, "Discrete-Time Signal Processing", p.475-476.
///  Examples
///  --------
///  Suppose we want to design a lowpass filter, with 65 dB attenuation
///  in the stop band.  The Kaiser window parameter to be used in the
///  window method is computed by `kaiser_beta(65)`:
///  >>> from scipy.signal import kaiser_beta
///  >>> kaiser_beta(65)
///  6.20426
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
