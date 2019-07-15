import 'package:scidart/numdart/numdart.dart';

import 'general_cosine.dart';

Array nuttall(int M, {bool sym = true}) {
  return generalCosine(M, Array([0.3635819, 0.4891775, 0.1365995, 0.0106411]), sym: sym);
}