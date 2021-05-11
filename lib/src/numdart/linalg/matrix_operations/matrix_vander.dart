import '../../../numdart/numdart.dart';

/// Generate a Vandermonde matrix.
/// The columns of the output matrix are powers of the input vector. The
/// order of the powers is determined by the `increasing` boolean argument.
/// Specifically, when `increasing` is False, the `i`-th output column is
/// the input vector raised element-wise to the power of ``N - i - 1``. Such
/// a matrix with a geometric progression in each row is named for Alexandre-
/// Theophile Vandermonde.
///
/// # Parameters
/// - [x] : input array
/// - [N] : int, optional
/// Number of columns in the output.  If `N` is not specified, a square
/// array is returned (``N = x.length``).
/// - [increasing] : bool, optional
/// Order of the powers of the columns.  If true, the powers increase
/// from left to right, if false (the default) they are reversed.
///
/// # Returns
/// out : Array2d
/// Vandermonde matrix.  If `increasing` is False, the first column is
/// `x^(N-1)``, the second ``x^(N-2)`` and so forth. If `increasing` is
/// True, the columns are ``x^0, x^1, ..., x^(N-1)``.
///
/// # Examples
/// ```dart
/// var x = Array([2.0, 4.0, 8.0]);
///
/// print(vander(x));
/// print(vander(x, increasing: true));
///
/// /* output:
/// Array2d([
///   Array([4.0, 2.0, 1.0]),
///   Array([16.0, 4.0, 1.0]),
///   Array([64.0, 8.0, 1.0])
/// ])
///
/// Array2d([
///   Array([1.0, 2.0, 4.0]),
///   Array([1.0, 4.0, 16.0]),
///   Array([1.0, 8.0, 64.0])
/// ])
/// */
/// ```
Array2d matrixVander(Array x, {int? N, bool increasing = false}) {
  N ??= x.length;
  if (N <= 0) {
    throw FormatException('N must be greater than 0 (N > 0)');
  }

  var v = Array2d.fixed(x.length, N);

  // create other vander terms: column 0 - N
  for (var row = 0; row < x.length; row++) {
    // create a matrix increasing order
    if (increasing) {
      for (var column = 0; column < N; column++) {
        v[row][column] = pow(x[row], column).toDouble();
      }
    }
    // create a matrix decreasing order
    else {
      for (var column = 0; column < N; column++) {
        v[row][column] = pow(x[row], N - 1 - column).toDouble();
      }
    }
  }

  return v;
}
