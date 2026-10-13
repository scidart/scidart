import 'package:scidart/src/numdart/arrays_base/array.dart';

/// Return the median of an array. The input array is not modified.
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3]);
///
/// print(median(n));
///
/// /* output:
/// 2.0
/// */
/// ```
double median(Array a) {
  if (a.isEmpty) {
    throw FormatException('median of an empty array is undefined');
  }
  // sort a copy so the caller's array is not reordered
  var sorted = a.toList()..sort();
  var middle = sorted.length ~/ 2;
  if (sorted.length % 2 == 1) {
    return sorted[middle];
  } else {
    return (sorted[middle - 1] + sorted[middle]) / 2.0;
  }
}
