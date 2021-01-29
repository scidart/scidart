import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/linalg/decompositions/svd.dart';

/// Two norm
/// return maximum singular value.
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([1, 2, 3]),
///   Array([1, 2, 3]),
///   Array([1, 2, 3]),
/// ]);
///
/// print(a.norm2());
///
/// /* output:
/// 6.496425037213701
/// */
/// ```
double matrixNormTwo(Array2d a) {
  return SVD(a).norm2();
}
