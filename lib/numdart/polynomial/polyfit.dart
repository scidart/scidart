import 'package:scidart/numdart/array/array.dart';
import 'package:scidart/numdart/linalg//vander.dart';

//https://en.wikipedia.org/wiki/Polynomial_regression
//https://rosettacode.org/wiki/Polynomial_regression#C_sharp
//https://github.com/numpy/numpy/blob/v1.15.0/numpy/lib/polynomial.py#L393-L606
//https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.polyfit.html
Array polyfit(Array x, Array y, int degree) {
  // Vandermonde matrix
  var v = vander(x);

  var yv = y.toColumnMatrix();
  var qr = v.QRDecomposition();
  // Math.Net doesn't have an "economy" QR, so:
  // cut R short to square upper triangle, then recompute Q
  var r = qr.R().subMatrix(0, degree + 1, 0, degree + 1);

  print(v);
  print(r);
//  var r = qr.R();
  var q = v.dot(r.inverse());
  var p = r.inverse().dot(q.transpose().dot(yv));
  return p.columnToArray(0);
}