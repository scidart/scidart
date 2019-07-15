import 'package:scidart/numdart/numdart.dart';

import 'general_cosine.dart';

Array flattop(int M, {bool sym = true}) {
  var a = Array([0.21557895, 0.41663158, 0.277263158, 0.083578947, 0.006947368]);
  return generalCosine(M, a, sym: sym);
}