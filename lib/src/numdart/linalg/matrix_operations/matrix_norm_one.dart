import 'dart:math' as math;

import 'package:scidart/src/numdart/arrays_base/array2d.dart';

/// One norm
/// return maximum column sum.
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([1, 2, 3]),
///   Array([1, 2, 3]),
///   Array([1, 2, 3]),
/// ]);
///
/// print(a.norm1());
///
/// /* output:
/// 9
/// */
double matrixNormOne(Array2d a) {
  var f = 0.0;
  for (var j = 0; j < a.column; j++) {
    var s = 0.0;
    for (var i = 0; i < a.row; i++) {
      s += a[i][j].abs();
    }
    f = math.max(f, s);
  }
  return f;
}
