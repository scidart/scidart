import 'package:scidart/src/numdart/arrays_base/array.dart';
import 'package:scidart/src/numdart/fastmath/dart_math_operations/dart_math_operations.dart';
import 'package:scidart/src/numdart/statistic/variance.dart';

///  Return the standard deviation of sample array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> standardDeviation(n);
///
double standardDeviation(Array a) {
  return sqrt(variance(a));
}
