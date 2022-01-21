import '../array.dart';

/// Calculate the n-th discrete difference of an Array using the formula
/// `out[i] = a[i+1] - a[i]`.
///
/// # Parameters
/// [a] : input array
/// return an Array with all the differences.
///
/// ## References
/// 1. "numpy.diff". https://github.com/numpy/numpy/blob/v1.17.0/numpy/lib/function_base.py#L1147-L1275. Retrieved 2019-07-31.
/// 2. "doc numpy.diff". https://docs.scipy.org/doc/numpy/reference/generated/numpy.diff.html. Retrieved 2019-07-31.
/// 3. "numpy array indexing". https://docs.scipy.org/doc/numpy/reference/arrays.indexing.html. Retrieved 2019-07-31.
///
/// # Examples
/// ```dart
/// var a = Array([1, 2, 4, 7, 0]);
///
/// print(arrayDiff(a));
///
/// /* expected output:
/// Array([ 1,  2,  3, -7]);
/// */
/// ```
Array arrayDiff(Array a) {
  var b = a.getRangeArray(0, a.length - 1);
  var c = a.getRangeArray(1, a.length);

  return c - b;
}
