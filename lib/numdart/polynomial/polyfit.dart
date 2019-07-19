import 'package:scidart/numdart/array/array.dart';
import 'package:scidart/numdart/array/array2d.dart';
import 'package:scidart/numdart/linalg//vander.dart';
import 'package:scidart/numdart/linalg/qr.dart';
import 'package:scidart/numdart/statistic/mean.dart';

//https://en.wikipedia.org/wiki/Polynomial_regression
//https://rosettacode.org/wiki/Polynomial_regression#C_sharp
//https://github.com/numpy/numpy/blob/v1.15.0/numpy/lib/polynomial.py#L393-L606
//https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.polyfit.html
Array polyfit(Array x, Array y, int degree) {
  // Vandermonde matrix
  var v = vander(x, increasing: true);

  var yv = y.toColumnMatrix();
  var qr = v.QRDecomposition();
  // Math.Net doesn't have an "economy" QR, so:
  // cut R short to square upper triangle, then recompute Q
//  var r = qr.R().subMatrix(0, degree + 1, 0, degree + 1);
  var r = qr.R();

  print(v);
  print(r);
  var q = v.dot(r.inverse());
  var p = r.inverse().dot(q.transpose().dot(yv));
  print(p);
  return p.columnToArray(0);
}

//https://algs4.cs.princeton.edu/14analysis/PolynomialRegression.java.html
Array2d polynomialRegression(Array x, Array y, int degree) {
  int n = x.length;
  QR qr;
  Array2d matrixX;

  // in case Vandermonde matrix does not have full rank, reduce degree until it does
  while (true) {
    // build Vandermonde matrix
    matrixX = vander(x);

    // find least squares solution
    qr = QR(matrixX);
    if (qr.isFullRank()) {
      break;
    }

    // decrease degree and try again
    degree--;
  }

  // create matrix from vector
  Array2d matrixY = Array2d.fromVector(y, n);

  // linear regression coefficients
  var beta = qr.solve(matrixY);

  // mean of y[] values
  double meany = mean(y);

  // total variation to be accounted for
  var sst = 0.0;
  for (int i = 0; i < n; i++) {
    double dev = y[i] - meany;
    sst += dev * dev;
  }

  // variation not accounted for
  var residuals = matrixX.dot(beta) - matrixY;
  var sse = residuals.norm2() * residuals.norm2();

  return beta;
}