import 'package:scidart/numdart/numdart.dart';

import 'general_hamming.dart';

Array hamming(int M, {bool sym = true}) {
  return generalHamming(M, 0.54, sym: sym);
}