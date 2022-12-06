import 'package:scidart/numdart.dart';

/// Return numbers spaced evenly on a log scale.
///
/// In linear space, the sequence starts at [base]^[start] (base to the power
/// of start) and ends with [base]^[stop] (depending on [endpoint] flag).
///
/// Example:
/// ```dart
/// var result = logSpace(1, 3, num: 3);
/// print(result); // Array([100.0, 215.443469, 464.158883])
/// ```
///
/// The generated array will contain [num] elements if [endpoint] is true;
/// otherwise, [num] minus 1 elements will be generated, leaving the last number
/// out.
///
/// Example:
/// ```dart
/// var result = logSpace(1, 3, num: 3, endpoint: false);
/// print(result); // Array([100.0, 215.443469])
/// ```
Array logSpace(
  num start,
  num stop, {
  num base = 10.0,
  int num = 50,
  bool endpoint = true,
}) {
  var result = Array.fixed(endpoint ? num : num - 1);
  var x = start;
  final increment = (stop - start) / (num - 1);

  for (var i = 0; i < result.length; i++) {
    result[i] = pow(base, x).toDouble();
    x += increment;
  }

  return result;
}
