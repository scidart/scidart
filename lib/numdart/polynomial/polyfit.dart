import 'package:scidart/numdart/array/array.dart';
import 'package:scidart/numdart/linalg//vander.dart';

Array polyfit(Array x, Array y, int degree) {
  // Vandermonde matrix
  var v = vander(x);

  var yv = y.toColumnMatrix();
  var qr = v.QRDecomposition();
  // Math.Net doesn't have an "economy" QR, so:
  // cut R short to square upper triangle, then recompute Q
  var r = qr.R().subMatrix(0, degree + 1, 0, degree + 1);
  var q = v.dot(r.inverse());
  var p = r.Inverse().Multiply(q.TransposeThisAndMultiply(yv));
  return p.Column(0).ToArray();
}