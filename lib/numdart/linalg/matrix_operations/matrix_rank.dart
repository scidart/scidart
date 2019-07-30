import 'package:scidart/numdart/arrays_base/arrays_base.dart';
import 'package:scidart/numdart/linalg/decompositions/svd.dart';

///  Matrix rank
///  return rank, obtained from SVD.
int matrixRank(Array2d a) {
  return SVD(a).rank();
}
