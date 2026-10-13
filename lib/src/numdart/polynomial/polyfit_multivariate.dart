import 'dart:math' as math;

import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/polynomial/least_squares.dart';

/// Polynomial regression with several input features and several outputs.
///
/// Fits every output as a polynomial of degree [degree] of the features,
/// including the interaction terms (`x0 * x1`, `x0^2 * x2`...), by least
/// squares. It is equivalent to `sklearn.preprocessing.PolynomialFeatures`
/// followed by a linear regression without intercept, and the terms follow
/// the same order (see [powers]).
///
/// When there are not enough samples for the number of terms, the minimum
/// norm least squares solution is used, like `numpy.linalg.lstsq`.
///
/// # References
/// 1. "Polynomial regression". https://en.wikipedia.org/wiki/Polynomial_regression. Retrieved 2026-10-13.
/// 2. "sklearn.preprocessing.PolynomialFeatures". https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.PolynomialFeatures.html. Retrieved 2026-10-13.
/// 3. "numpy.linalg.lstsq". https://numpy.org/doc/stable/reference/generated/numpy.linalg.lstsq.html. Retrieved 2026-10-13.
///
/// # Examples
/// ```dart
/// // z = 1 + 2a + 3b + ab, with two features (a, b) and one output
/// var x = Array2d([
///   Array([0, 0]), Array([1, 0]), Array([0, 1]),
///   Array([1, 1]), Array([2, 1]), Array([1, 2]),
/// ]);
/// var y = Array2d(x.map((r) => Array([1 + 2 * r[0] + 3 * r[1] + r[0] * r[1]])).toList());
///
/// var p = PolyFitMultivariate(x, y, 2);
///
/// print(p.predict(Array([2, 2])));
///
/// /* output:
/// Array([15.000000000000004])
/// */
/// ```
class PolyFitMultivariate {
  /// Degree of the polynomial.
  final int degree;

  /// Number of input features.
  final int featureCount;

  /// Number of outputs.
  final int outputCount;

  /// Exponent of each feature in each term: `powers[t][f]` is the exponent
  /// of feature `f` in term `t`. Same order as `PolynomialFeatures.powers_`.
  final List<List<int>> powers;

  /// Rank of the matrix of terms. Smaller than [powers].length when there
  /// are not enough distinct samples for all the terms.
  late final int rank;

  /// Coefficients: `coefficients[t][o]` multiplies term `t` for output `o`.
  late final Array2d coefficients;

  final Array _sse;
  final Array _sst;

  /// Fits the polynomial.
  /// - [x] : samples, one row per sample and one column per feature
  /// - [y] : outputs, one row per sample and one column per output
  /// - [degree] : degree of the polynomial, >= 0
  PolyFitMultivariate(Array2d x, Array2d y, this.degree)
      : featureCount = x.isEmpty ? 0 : x[0].length,
        outputCount = y.isEmpty ? 0 : y[0].length,
        powers = _powers(x.isEmpty ? 0 : x[0].length, degree),
        _sse = Array.fixed(y.isEmpty ? 0 : y[0].length, initialValue: 0.0),
        _sst = Array.fixed(y.isEmpty ? 0 : y[0].length, initialValue: 0.0) {
    if (degree < 0) {
      throw FormatException('expected degree >= 0');
    }
    if (x.isEmpty || featureCount == 0) {
      throw FormatException('expected at least one sample and one feature');
    }
    if (y.length != x.length) {
      throw FormatException('expected x and y to have the same number of rows');
    }
    if (outputCount == 0) {
      throw FormatException('expected at least one output');
    }
    for (var i = 0; i < x.length; i++) {
      if (x[i].length != featureCount || y[i].length != outputCount) {
        throw FormatException('row $i has a different number of columns');
      }
      if (x[i].any((v) => !v.isFinite) || y[i].any((v) => !v.isFinite)) {
        throw FormatException('expected only finite values in x and y');
      }
    }

    var design = Array2d(x.map(_terms).toList());
    if (!isFiniteMatrix(design)) {
      throw FormatException('a power of x overflows, reduce the degree');
    }
    var scale = normalizeColumns(design);
    var (solution, solutionRank) = leastSquares(design, y.copy());
    rank = solutionRank;
    for (var t = 0; t < solution.row; t++) {
      for (var o = 0; o < outputCount; o++) {
        solution[t][o] /= scale[t];
      }
    }
    coefficients = solution;

    for (var o = 0; o < outputCount; o++) {
      var meanY = 0.0;
      for (var i = 0; i < y.length; i++) {
        meanY += y[i][o];
      }
      meanY /= y.length;
      for (var i = 0; i < y.length; i++) {
        var dev = y[i][o] - meanY;
        _sst[o] += dev * dev;
      }
    }
    for (var i = 0; i < x.length; i++) {
      var predicted = predict(x[i]);
      for (var o = 0; o < outputCount; o++) {
        var residual = predicted[o] - y[i][o];
        _sse[o] += residual * residual;
      }
    }
  }

  /// Predicted outputs for one sample with [featureCount] features.
  Array predict(Array features) {
    if (features.length != featureCount) {
      throw FormatException(
          'expected $featureCount features, got ${features.length}');
    }
    var terms = _terms(features);
    var out = Array.fixed(outputCount, initialValue: 0.0);
    for (var t = 0; t < terms.length; t++) {
      for (var o = 0; o < outputCount; o++) {
        out[o] += coefficients[t][o] * terms[t];
      }
    }
    return out;
  }

  /// Predicted outputs for each row of [samples].
  Array2d predictAll(Array2d samples) => Array2d(samples.map(predict).toList());

  /// Coefficient of determination R² of each output (1.0 for a constant
  /// output).
  Array R2() => Array(List.generate(
      outputCount, (o) => _sst[o] == 0.0 ? 1.0 : 1.0 - _sse[o] / _sst[o]));

  /// Sum of squared residuals of each output.
  Array sse() => Array(_sse.toList());

  /// Values of the terms ([powers]) for one sample.
  Array _terms(Array sample) {
    return Array(powers.map((p) {
      var v = 1.0;
      for (var f = 0; f < p.length; f++) {
        if (p[f] > 0) v *= math.pow(sample[f], p[f]).toDouble();
      }
      return v;
    }).toList());
  }

  /// Exponents of all monomials up to [degree], ordered by degree and then
  /// lexicographically by feature index (itertools
  /// combinations_with_replacement order).
  static List<List<int>> _powers(int features, int degree) {
    var result = <List<int>>[];
    void combine(int start, int left, List<int> current) {
      if (left == 0) {
        result.add(List.of(current));
        return;
      }
      for (var f = start; f < features; f++) {
        current[f]++;
        combine(f, left - 1, current);
        current[f]--;
      }
    }

    for (var d = 0; d <= degree; d++) {
      combine(0, d, List.filled(features, 0));
    }
    return result;
  }

  @override
  String toString() =>
      'PolyFitMultivariate(degree: $degree, features: $featureCount, '
      'outputs: $outputCount, R2: ${R2().toList()})';
}
