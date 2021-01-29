import 'package:scidart/src/numdart/arrays_base/array.dart';

/// Return the mode of all elements of the array
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
  var maxValue = 0.0;
  var maxCount = 0;

  for (var i = 0; i < a.length; ++i) {
    var count = 0;
    for (var j = 0; j < a.length; ++j) {
      if (a[j] == a[i]) ++count;
    }
    if (count > maxCount) {
      maxCount = count;
      maxValue = a[i];
    }
  }
  return maxValue;
}
