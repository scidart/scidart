import 'package:scidart/numdart/numdart.dart';

import 'general_cosine.dart';

Array blackman(int M, {bool sym = true}) {
  return generalCosine(M, Array([0.42, 0.50, 0.08]), sym: sym);
}