import 'dart:math' as math;

import 'package:scidart/src/numdart/arrays_base/array2d.dart';

///  One norm
///  return    maximum column sum.
///  Examples
///  --------
///  >>> var a = Array2d([
///  >>>   Array([1, 2, 3]),
///  >>>   Array([1, 2, 3]),
///  >>>   Array([1, 2, 3]),
///  >>> ]);
///  >>> a.norm1();
///  >>> 9
double matrixNormOne(Array2d a) {
  double f = 0;
  for (int j = 0; j < a.column; j++) {
    double s = 0;
    for (int i = 0; i < a.row; i++) {
      s += a[i][j].abs();
    }
    f = math.max(f, s);
  }
  return f;
}
