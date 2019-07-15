import 'package:scidart/numdart/numdart.dart';

import 'general_cosine.dart';

Array blackmanharris(int M, {bool sym = true}) {
  return generalCosine(M, Array([0.35875, 0.48829, 0.14128, 0.01168]), sym: sym);
}