import 'package:scidart/numdart.dart';

/// Find the peak of Array
/// - [a] : Array input
/// - [threshold] : optional, only consider peaks greater equal then peaks
///
/// # Return List
/// - [ix] : list of indexes of the peak in the array
/// - [ax] : list of the value of the peaks found
///
/// # References
/// 1. "Java Program to Find the Peak Element of an Array O(n) time (Naive Method)". https://www.sanfoundry.com/java-program-find-peak-element-array-on-times/. Retrieved 2019-08-12.
///
/// # Examples
/// ```dart
/// var a = Array([0, 1, 2, 2, 1, 0 , 0, 1, 0]);
///
/// print(findPeaks(a));
///
/// /* output:
/// [ Array([2.0, 3.0, 7.0]),
///   Array([2.0, 2.0, 1.0]) ]
/// */
/// ```
List findPeaks(Array a, {double? threshold}) {
  var N = a.length - 2;
  var ix = Array.empty();
  var ax = Array.empty();

  if (threshold != null) {
    for (var i = 1; i <= N; i++) {
      if (a[i - 1] <= a[i] && a[i] >= a[i + 1] && a[i] >= threshold) {
        ix.add(i.toDouble());
        ax.add(a[i]);
      }
    }
  } else {
    for (var i = 1; i <= N; i++) {
      if (a[i - 1] <= a[i] && a[i] >= a[i + 1]) {
        ix.add(i.toDouble());
        ax.add(a[i]);
      }
    }
  }
  return [ix, ax];
}
