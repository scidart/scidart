import '../../numdart.dart';

///  Matrix determinant
///  return     determinant
double matrixDeterminant(Array2d a) {
  return LU(a).det();
}
