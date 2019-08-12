import 'package:scidart/src/numdart/arrays_base/array.dart';

///  Return the mode of all elements of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3, 3]);
///  >>> mode(n);
///  3.0
double mode(Array a) {
  double maxValue = 0;
  int maxCount = 0;

  for (int i = 0; i < a.length; ++i) {
    int count = 0;
    for (int j = 0; j < a.length; ++j) {
      if (a[j] == a[i]) ++count;
    }
    if (count > maxCount) {
      maxCount = count;
      maxValue = a[i];
    }
  }
  return maxValue;
}
