import 'package:scidart/numdart/array/array.dart';
import 'package:scidart/numdart/linalg//vander.dart';

Array Polyfit(Array x, Array y, int degree) {
  // Vandermonde matrix
  var v = vander(x);

  var yv = y.ToColumnMatrix();
  QR qr = v.QR();
  // Math.Net doesn't have an "economy" QR, so:
  // cut R short to square upper triangle, then recompute Q
  var r = qr.R.SubMatrix(0, degree + 1, 0, degree + 1);
  var q = v.Multiply(r.Inverse());
  var p = r.Inverse().Multiply(q.TransposeThisAndMultiply(yv));
  return p.Column(0).ToArray();
}