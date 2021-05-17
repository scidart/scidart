import 'package:scidart/src/numdart/arrays_base/array2d.dart';

/// generate a submatrix from a given interval
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([2, 2, 2]),
///   Array([2, 2, 2]),
///   Array([2, 2, 2])
/// ]);
///
/// print(matrixSub(a, 0, 1, 0, 1));
///
/// /* output:
/// Array2d([
///   Array([2, 2]),
///   Array([2, 2])
/// ]);
/// */
/// ```
Array2d matrixSub(Array2d a, int i0, int i1, int j0, int j1) {
  var b = Array2d.fixed(i1 - i0 + 1, j1 - j0 + 1);
  try {
    for (var i = i0; i <= i1 && i < a.row; i++) {
      for (var j = j0; j <= j1 && j < a.column; j++) {
        b[i - i0][j - j0] = a[i][j];
      }
    }
  } catch (e) {
    throw FormatException('Submatrix indices ${e.toString()}');
  }
  return b;
}
