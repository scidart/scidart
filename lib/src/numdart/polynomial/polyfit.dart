import 'dart:math' as math;

import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/linalg/decompositions/qr.dart';
import 'package:scidart/src/numdart/linalg/matrix_operations/matrix_vander.dart';
import 'package:scidart/src/numdart/statistic/mean.dart';

/// The PolynomialRegression class performs a polynomial regression
/// on an set of <em>N</em> data points (<em>y<sub>i</sub></em>, <em>x<sub>i</sub></em>).
/// That is, it fits a polynomial
/// <em>y</em> = &beta;<sub>0</sub> +  &beta;<sub>1</sub> <em>x</em> +
/// &beta;<sub>2</sub> <em>x</em><sup>2</sup> + ... +
/// &beta;<sub><em>d</em></sub> <em>x</em><sup><em>d</em></sup>
/// (where <em>y</em> is the response variable, <em>x</em> is the predictor variable,
/// and the &beta;<sub><em>i</em></sub> are the regression coefficients)
/// that minimizes the sum of squared residuals of the multiple regression model.
/// It also computes associated the coefficient of determination <em>R</em><sup>2</sup>.
/// This implementation performs a QR-decomposition of the underlying
/// Vandermonde matrix, so it is neither the fastest nor the most numerically
/// stable way to perform the polynomial regression.
///
/// # References
/// 1. "Polynomial regression". https://en.wikipedia.org/wiki/Polynomial_regression. Retrieved 2019-07-22.
/// 2. "Polynomial regression". //https://rosettacode.org/wiki/Polynomial_regression#C_sharp. Retrieved 2019-07-22.
/// 3. "polynomial.py". https://github.com/numpy/numpy/blob/v1.15.0/numpy/lib/polynomial.py#L393-L606. Retrieved 2019-07-22.
/// 4. "numpy.polyfit". https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.polyfit.html. Retrieved 2019-07-22.
/// 5. "Princeton Analysis Polynomial Regression". https://algs4.cs.princeton.edu/14analysis/PolynomialRegression.java.html. Retrieved 2019-07-22.
///
///
/// # Examples
/// ```dart
/// const int degree = 2;
/// var x = Array([0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]);
/// var y = Array([1.0, 6.0, 17.0, 34.0, 57.0, 86.0, 121.0, 162.0, 209.0, 262.0, 321.0]);
/// var p = PolyFit(x, y, degree);
///
/// print(p);
///
/// /*
/// 2.999999999999736 x^2 +  2.0000000000002807 x +  1.0000000000000122   (R^2 = 0.9922700105981427)
/// */
/// ```
class PolyFit {
  String variableName = 'x'; // name of the predictor variable private
  int degree = 0; // degree of the polynomial regression private
  Array2d beta =
      Array2d.empty(); // the polynomial regression coefficients private
  double sse = 0; // sum of squares due to error private
  double sst = 0; // total sum of squares private

  ///  Performs a polynomial reggression on the data points (y\[i\], x\[i\]).
  ///  [x] the values of the predictor variable
  ///  [y] the corresponding values of the response variable
  ///  [degree] the degree of the polynomial to fit
  PolyFit(Array x, Array y, this.degree) {
    if (degree < 0) {
      throw FormatException('expected deg >= 0');
    }
    if (x.isEmpty) {
      throw FormatException('expected non-empty vector for x');
    }
    if (x.length != y.length) {
      throw FormatException('expected x and y to have same length');
    }

    for (var i = 0; i < x.length; i++) {
      if (!x[i].isFinite || !y[i].isFinite) {
        throw FormatException('expected only finite values in x and y');
      }
    }

    var n = x.length;
    QR qr;
    Array scale;

    // in case Vandermonde matrix does not have full rank, reduce degree until it does
    while (true) {
      // build Vandermonde matrix with columns scaled to unit norm, as numpy
      // does, so the rank test does not depend on the magnitude of x
      var matrixX = matrixVander(x, N: degree + 1, increasing: true);
      scale = _normalizeColumns(matrixX);

      // find least squares solution
      qr = QR(matrixX);
      var tolerance = math.max(n, degree + 1) * _machineEpsilon;
      if (qr.isFullRank(tolerance: tolerance)) break;

      // decrease degree and try again
      degree--;

      if (degree < 0) {
        throw FormatException('Matrix is rank deficient.');
      }
    }

    // create matrix from vector
    var matrixY = Array2d.fromVector(y, n);

    // linear regression coefficients, undoing the column scaling
    beta = qr.solve(matrixY);
    for (var j = 0; j < beta.row; j++) {
      beta[j][0] /= scale[j];
    }

    // mean of y[] values
    var meany = mean(y);

    // total variation to be accounted for
    for (var i = 0; i < n; i++) {
      var dev = y[i] - meany;
      sst += dev * dev;
    }

    // variation not accounted for
    for (var i = 0; i < n; i++) {
      var residual = predict(x[i]) - y[i];
      sse += residual * residual;
    }
  }

  ///  Returns the {@code j}th regression coefficient.
  ///  [j] the index
  ///  return the {@code j}th regression coefficient
  double coefficient(int j) {
    // to make -0.0 print as 0.0
    if (beta[j][0].abs() < 1E-4) return 0.0;
    return beta[j][0];
  }

  ///  Returns the degree of the polynomial to fit.
  ///  return the degree of the polynomial to fit
  int polyDegree() {
    return degree;
  }

  ///  Returns the coefficient of determination <em>R</em><sup>2</sup>.
  ///  return the coefficient of determination <em>R</em><sup>2</sup>,
  ///  which is a real number between 0 and 1
  double R2() {
    if (sst == 0.0) return 1.0; // constant function
    return 1.0 - sse / sst;
  }

  ///  Returns the expected response {@code y} given the value of the predictor
  ///  variable {@code x}.
  ///  [x] the value of the predictor variable
  ///  return the expected response {@code y} given the value of the predictor
  ///  variable {@code x}
  double predict(double x) {
    // horner's method
    var y = 0.0;
    for (var j = beta.row - 1; j >= 0; j--) {
      y = beta[j][0] + (x * y);
    }
    return y;
  }

  ///  return the coefficients of the polynomial regression
  ///  p(x) = p[0] * x**deg + ... + p\[deg\]
  Array coefficients() {
    var coeff = Array.empty();
    var j = beta.row - 1;

    // ignoring leading zero coefficients
    while (j >= 0 && beta[j][0].abs() < 1E-5) {
      j--;
    }

    // create remaining terms
    while (j >= 0) {
      coeff.add(beta[j][0]);
      j--;
    }

    return coeff;
  }

  ///  Returns a string representation of the polynomial regression model.
  ///  return a string representation of the polynomial regression model,
  ///  including the best-fit polynomial and the coefficient of
  ///  determination <em>R</em><sup>2</sup>
  @override
  String toString() {
    var s = <String>[];
    var j = beta.row - 1;

    // ignoring leading zero coefficients
    while (j >= 0 && beta[j][0].abs() < 1E-5) {
      j--;
    }

    // create remaining terms
    while (j >= 0) {
      if (j == 0) {
        s.add('${beta[j][0]}');
      } else if (j == 1) {
        s.add('${beta[j][0]} $variableName + ');
      } else {
        s.add('${beta[j][0]} $variableName^$j + ');
      }
      j--;
    }
    s.add('  (R^2 = ${R2()})');

    // replace "+ -2n" with "- 2n"
    return s.join(' ').replaceAll('+ -', '- ');
  }

  ///  Compare lexicographically.
  int compareTo(PolyFit that) {
    var EPSILON = 1E-5;
    var maxDegree = math.max(polyDegree(), that.polyDegree());
    for (var j = maxDegree; j >= 0; j--) {
      var term1 = 0.0;
      var term2 = 0.0;
      if (polyDegree() >= j) term1 = beta[j][0];
      if (that.polyDegree() >= j) term2 = that.beta[j][0];
      if (term1.abs() < EPSILON) term1 = 0.0;
      if (term2.abs() < EPSILON) term2 = 0.0;
      if (term1 < term2) {
        return -1;
      } else if (term1 > term2) {
        return 1;
      }
    }
    return 0;
  }

  static const double _machineEpsilon = 2.220446049250313e-16;

  /// Scales each column of [m] to unit norm in place and returns the scales.
  static Array _normalizeColumns(Array2d m) {
    var scale = Array.fixed(m.column);
    for (var j = 0; j < m.column; j++) {
      var norm = 0.0;
      for (var i = 0; i < m.row; i++) {
        norm += m[i][j] * m[i][j];
      }
      norm = math.sqrt(norm);
      if (norm == 0.0) norm = 1.0;
      scale[j] = norm;
      for (var i = 0; i < m.row; i++) {
        m[i][j] /= norm;
      }
    }
    return scale;
  }
}
