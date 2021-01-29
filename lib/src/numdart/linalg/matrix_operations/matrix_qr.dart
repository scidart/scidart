import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/linalg/decompositions/qr.dart';

/// Generate a QR decomposition of the matrix
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([2.123456789, 2.123456789, 2.123456789]),
///   Array([2.123456789, 2.123456789, 2.123456789]),
///   Array([2.123456789, 2.123456789, 2.123456789])
/// ]);
/// var qr = QRDecomposition(a);
/// ```
QR matrixQR(Array2d a) {
  a.isMatrix();
  return QR(a);
}
