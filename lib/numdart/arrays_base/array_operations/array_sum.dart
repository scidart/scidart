import '../array.dart';

///  Return the sum of all elements of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> arraySum(n);
///  6.0
double arraySum(Array a) {
  double sum = 0.0;
  for (int i = 0; i < a.length; i++) {
    sum += a[i];
  }
  return sum;
}
