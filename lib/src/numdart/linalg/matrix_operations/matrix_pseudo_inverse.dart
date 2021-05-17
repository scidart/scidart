import 'package:scidart/numdart.dart';

/// Pseudo inverse matrix using Moore–Penrose
/// return inverse(A) if A is square, pseudoinverse otherwise.
///
/// # Examples
/// ```dart
/// var a = Array2d([
///   Array([1.0, 2.0, 3.0]),
///   Array([4.0, 5.0, 6.0]),
/// ]);
///
/// print(matrixInverse(a));
///
/// /* output:
/// Array2d([
///   Array([-0.94444441, 0.44444443]),
///   Array([-0.11111108, 0.1111111]),
///   Array([0.72222224, -0.22222223])
/// ])
/// */
/// ```
///
/// # References
/// 1. "Open IMAJ Pseudo Inverse Matrix". https://github.com/wuchubuzai/OpenIMAJ/blob/master/core/core-math/src/main/java/org/openimaj/math/matrix/PseudoInverse.java . Retrieved 2021-05-17.
/// 2. "Moore–Penrose inverse". https://en.wikipedia.org/wiki/Moore%E2%80%93Penrose_inverse . Retrieved 2021-05-17.
/// 3. "Dense matrix". https://github.com/fommil/matrix-toolkits-java/blob/master/src/main/java/no/uib/cipr/matrix/DenseMatrix.java . Retrieved 2021-05-17.
/// 4. "Moore-Penrose Pseudoinverse of a Matrix calculator". https://atozmath.com/MatrixEv.aspx?q=pseudoinverse&q1=1%2c2%2c3%3b4%2c5%2c6%60pseudoinverse%60&dm=D&dp=8&do=1#PrevPart . Retrieved 2021-05-17.
/// 5. "Wolfram Alpha". https://www.wolframalpha.com/input/?i=pseudoinverse+%5B%5B1%2C2%2C3%5D%2C%5B4%2C5%2C6%5D%5D . Retrieved 2021-05-17.
///
Array2d matrixPseudoInverse(Array2d matrix) {
  var svd = SVD(matrix);

  var sInv = svd.S();
  array2dInverseOfEachElement(sInv);
  sInv = matrixTranspose(sInv);

  var vT = svd.V();

  var uT = matrixTranspose(svd.U());

  var pinv = matrixDot(matrixDot(vT, sInv), uT);

  return pinv;
}
