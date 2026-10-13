import 'dart:math' as math;

import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/special/erf/erf.dart';

/// Normal (Gaussian) continuous distribution with mean [mean] and standard
/// deviation [std], equivalent to `scipy.stats.norm(loc=mean, scale=std)`.
///
/// # References
/// 1. "scipy.stats.norm". https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.norm.html. Retrieved 2026-10-13.
/// 2. "Normal distribution". https://en.wikipedia.org/wiki/Normal_distribution. Retrieved 2026-10-13.
/// 3. P. J. Acklam, "An algorithm for computing the inverse normal cumulative distribution function". https://web.archive.org/web/20151030215612/http://home.online.no/~pjacklam/notes/invnorm/. Retrieved 2026-10-13.
///
/// # Examples
/// ```dart
/// var n = NormalDistribution(mean: 10.0, std: 2.0);
///
/// print(n.pdf(10.0));
/// print(n.cdf(12.0));
/// print(n.ppf(0.975));
///
/// /* output:
/// 0.19947114020071635
/// 0.8413447460685429
/// 13.919927969080108
/// */
/// ```
class NormalDistribution {
  /// Mean (location) of the distribution.
  final double mean;

  /// Standard deviation (scale) of the distribution.
  final double std;

  /// Creates a normal distribution. [std] must be positive.
  NormalDistribution({this.mean = 0.0, this.std = 1.0}) {
    if (!mean.isFinite) {
      throw FormatException('mean must be finite, got $mean');
    }
    if (!(std > 0.0) || !std.isFinite) {
      throw FormatException('std must be positive and finite, got $std');
    }
  }

  /// Variance of the distribution.
  double get variance => std * std;

  /// Probability density function at [x].
  double pdf(double x) {
    var z = (x - mean) / std;
    return math.exp(-0.5 * z * z) / (_sqrt2Pi * std);
  }

  /// Logarithm of the probability density function at [x].
  double logPdf(double x) {
    var z = (x - mean) / std;
    return -0.5 * z * z - math.log(_sqrt2Pi * std);
  }

  /// Cumulative distribution function: probability of a value <= [x].
  double cdf(double x) => 0.5 * erfc(-(x - mean) / (std * math.sqrt2));

  /// Survival function `1 - cdf(x)`, accurate in the upper tail.
  double sf(double x) => 0.5 * erfc((x - mean) / (std * math.sqrt2));

  /// Percent point function (inverse of [cdf]): the value with
  /// `cdf(value) == p`, for p in [0, 1].
  double ppf(double p) => mean + std * _standardPpf(p);

  /// Inverse survival function: the value with `sf(value) == q`, for q in
  /// [0, 1]. Accurate for small q.
  double isf(double q) => mean - std * _standardPpf(q);

  /// Interval with the given [confidence] around the mean, as
  /// `[ppf((1 - confidence) / 2), isf((1 - confidence) / 2)]`.
  Array interval(double confidence) {
    if (confidence < 0.0 || confidence > 1.0) {
      throw FormatException('confidence must be in [0, 1], got $confidence');
    }
    var tail = (1.0 - confidence) / 2.0;
    return Array([ppf(tail), isf(tail)]);
  }

  /// Probability density function for each element of [x].
  Array pdfArray(Array x) => Array(x.map(pdf).toList());

  /// Cumulative distribution function for each element of [x].
  Array cdfArray(Array x) => Array(x.map(cdf).toList());

  /// Percent point function for each element of [p].
  Array ppfArray(Array p) => Array(p.map(ppf).toList());

  /// [n] random samples of the distribution (Box-Muller transform). Pass a
  /// seeded [random] for reproducible samples.
  Array sample(int n, {math.Random? random}) {
    if (n < 0) {
      throw FormatException('n must be >= 0, got $n');
    }
    random ??= math.Random();
    var samples = Array.fixed(n);
    for (var i = 0; i < n; i += 2) {
      // 1 - nextDouble() is in (0, 1], so the log is finite
      var u1 = 1.0 - random.nextDouble();
      var u2 = random.nextDouble();
      var r = math.sqrt(-2.0 * math.log(u1));
      samples[i] = mean + std * r * math.cos(2.0 * math.pi * u2);
      if (i + 1 < n) {
        samples[i + 1] = mean + std * r * math.sin(2.0 * math.pi * u2);
      }
    }
    return samples;
  }

  @override
  String toString() => 'NormalDistribution(mean: $mean, std: $std)';
}

const _sqrt2Pi = 2.5066282746310002;

const _ppfA = [
  -3.969683028665376e+01,
  2.209460984245205e+02,
  -2.759285104469687e+02,
  1.383577518672690e+02,
  -3.066479806614716e+01,
  2.506628277459239e+00,
];
const _ppfB = [
  -5.447609879822406e+01,
  1.615858368580409e+02,
  -1.556989798598866e+02,
  6.680131188771972e+01,
  -1.328068155288572e+01,
];
const _ppfC = [
  -7.784894002430293e-03,
  -3.223964580411365e-01,
  -2.400758277161838e+00,
  -2.549732539343734e+00,
  4.374664141464968e+00,
  2.938163982698783e+00,
];
const _ppfD = [
  7.784695709041462e-03,
  3.224671290700398e-01,
  2.445134137142996e+00,
  3.754408661907416e+00,
];

/// Inverse of the standard normal cdf. Acklam's approximation (relative
/// error 1.15e-9) refined by one step of Halley's method.
double _standardPpf(double p) {
  if (p.isNaN || p < 0.0 || p > 1.0) {
    throw FormatException('p must be in [0, 1], got $p');
  }
  if (p == 0.0) return double.negativeInfinity;
  if (p == 1.0) return double.infinity;

  // the lower half is computed directly; the upper half by symmetry, so the
  // refinement always works on the smaller tail probability
  if (p > 0.5) return -_standardPpf(1.0 - p);

  const pLow = 0.02425;
  double x;
  if (p < pLow) {
    var q = math.sqrt(-2.0 * math.log(p));
    x = (((((_ppfC[0] * q + _ppfC[1]) * q + _ppfC[2]) * q + _ppfC[3]) * q +
                    _ppfC[4]) *
                q +
            _ppfC[5]) /
        ((((_ppfD[0] * q + _ppfD[1]) * q + _ppfD[2]) * q + _ppfD[3]) * q + 1.0);
  } else {
    var q = p - 0.5;
    var r = q * q;
    x = (((((_ppfA[0] * r + _ppfA[1]) * r + _ppfA[2]) * r + _ppfA[3]) * r +
                    _ppfA[4]) *
                r +
            _ppfA[5]) *
        q /
        (((((_ppfB[0] * r + _ppfB[1]) * r + _ppfB[2]) * r + _ppfB[3]) * r +
                    _ppfB[4]) *
                r +
            1.0);
  }

  // below the smallest normal double the cdf is subnormal and too coarse for
  // Halley, and exp(x^2 / 2) overflows
  if (p < _minNormal) return _farTailPpf(p, x);

  // Halley refinement with the exact cdf
  var e = 0.5 * erfc(-x / math.sqrt2) - p;
  var u = e * _sqrt2Pi * math.exp(x * x / 2.0);
  return x - u / (1.0 + x * u / 2.0);
}

const _minNormal = 2.2250738585072014e-308;

/// Newton's method on log(cdf(x)) = log(p) for x below -37. log(cdf) comes
/// from the asymptotic series of the Mills ratio, which reaches double
/// precision with 8 terms there:
/// cdf(x) = pdf(x) / |x| * (1 - 1/x^2 + 3/x^4 - 15/x^6 + ...).
double _farTailPpf(double p, double x) {
  var logP = math.log(p);
  for (var i = 0; i < 3; i++) {
    var r = 1.0 / (x * x);
    var series = 1.0;
    var term = 1.0;
    for (var k = 1; k <= 8; k++) {
      term *= -(2 * k - 1) * r;
      series += term;
    }
    var logCdf =
        -0.5 * x * x - math.log(_sqrt2Pi) - math.log(-x) + math.log(series);
    // d/dx log(cdf(x)) = pdf(x) / cdf(x) = -x / series
    x -= (logCdf - logP) * series / -x;
  }
  return x;
}
