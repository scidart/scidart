import 'package:scidart/numdart/array/array2d.dart';

import '../array.dart';

///  Generate a Vandermonde matrix.
///  The columns of the output matrix are powers of the input vector. The
///  order of the powers is determined by the `increasing` boolean argument.
///  Specifically, when `increasing` is False, the `i`-th output column is
///  the input vector raised element-wise to the power of ``N - i - 1``. Such
///  a matrix with a geometric progression in each row is named for Alexandre-
///  Theophile Vandermonde.
///  Parameters
///  ----------
///  [x] : array_like
///      1-D input array.
///  [N] : int, optional
///      Number of columns in the output.  If `N` is not specified, a square
///      array is returned (``N = len(x)``).
///  [increasing] : bool, optional
///      Order of the powers of the columns.  If True, the powers increase
///      from left to right, if False (the default) they are reversed.
///      .. versionadded:: 1.9.0
///  Returns
///  -------
///  out : Array2d
///      Vandermonde matrix.  If `increasing` is False, the first column is
///      ``x^(N-1)``, the second ``x^(N-2)`` and so forth. If `increasing` is
///      True, the columns are ``x^0, x^1, ..., x^(N-1)``.
///  See Also
///  --------
///  polynomial.polynomial.polyvander
///  Examples
///  --------
///  >>> x = np.array([1, 2, 3, 5])
///  >>> N = 3
///  >>> np.vander(x, N)
///  array([[ 1,  1,  1],
///         [ 4,  2,  1],
///         [ 9,  3,  1],
///         [25,  5,  1]])
///  >>> np.column_stack([x**(N-1-i) for i in range(N)])
///  array([[ 1,  1,  1],
///         [ 4,  2,  1],
///         [ 9,  3,  1],
///         [25,  5,  1]])
///  >>> x = np.array([1, 2, 3, 5])
///  >>> np.vander(x)
///  array([[  1,   1,   1,   1],
///         [  8,   4,   2,   1],
///         [ 27,   9,   3,   1],
///         [125,  25,   5,   1]])
///  >>> np.vander(x, increasing=True)
///  array([[  1,   1,   1,   1],
///         [  1,   2,   4,   8],
///         [  1,   3,   9,  27],
///         [  1,   5,  25, 125]])
///  The determinant of a square Vandermonde matrix is the product
///  of the differences between the values of the input vector:
///  >>> np.linalg.det(np.vander(x))
///  48.000000000000043
///  >>> (5-3)*(5-2)*(5-1)*(3-2)*(3-1)*(2-1)
///  48
Array2d vander(Array x, {int N, bool increasing = false}) {
  if (N == null) {
    N = x.length;
  }

  var v = Array2d.fixed(x.length, N);

  var temp;
  if (increasing) {
    temp = v;
  } else {

  }

//  tmp = v[:, ::-1] if not increasing else v

  if (N > 0) {
    tmp[
  :, 0] = 1;
  }
  if (N > 1) {
  tmp[:, 1:] = x[:, None]
  multiply.accumulate(tmp[:, 1:], out=tmp[:, 1:], axis=1)
  }

  return
  v;
}