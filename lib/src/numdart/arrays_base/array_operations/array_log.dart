import '../../numdart.dart';
import '../array.dart';

/// Compute the natural logarithm for each element of the array
///
/// # Examples
/// ```dart
/// var n = Array([0.1, 1, 10, 100]);
/// var log = arrayLog(n);
///
/// print(log);
///
/// /* expected output:
/// Array([-2.3025850929940455, 0.0, 2.302585092994046, 4.605170185988092])
/// */
/// ```
Array arrayLog(Array a) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = log(a[i]); //fixme parallelize
  }
  return c;
}
