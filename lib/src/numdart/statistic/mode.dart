import 'package:scidart/src/numdart/arrays_base/array.dart';

/// Return the mode of all elements of the array. When more than one value
/// has the highest frequency, the first one found in the array is returned;
/// use [multimode] to get all of them.
///
/// # Examples
/// ```dart
/// var n = Array([1, 2, 3, 3]);
///
/// print(mode(n));
///
/// /* output:
/// 3.0
/// */
/// ```
double mode(Array a) {
  if (a.isEmpty) {
    throw FormatException('mode of an empty array is undefined');
  }
  return multimode(a).first;
}

/// Return all the most frequent values of the array, in the order they first
/// appear. When every value has the same frequency, all of them are returned
/// (same behavior as Python's `statistics.multimode`).
///
/// # Examples
/// ```dart
/// var n = Array([5, 0, 6, 8, 10, 8, 10]);
///
/// print(multimode(n));
///
/// /* output:
/// Array([8.0, 10.0])
/// */
/// ```
Array multimode(Array a) {
  var counts = <double, int>{};
  var maxCount = 0;
  for (var value in a) {
    var count = (counts[value] ?? 0) + 1;
    counts[value] = count;
    if (count > maxCount) maxCount = count;
  }

  var modes = Array.empty();
  counts.forEach((value, count) {
    if (count == maxCount) modes.add(value);
  });
  return modes;
}
