import '../array.dart';

///  Return the array with accumulative sum of all elements of the array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> arrayCumSum(n);
///  Array([1.0, 3.0, 6.0])
Array arrayCumSum(Array a) {
  double sum = 0.0;
  var b = Array.empty();
  for (int i = 0; i < a.length; i++) {
    sum += a[i];
    b.add(sum);
  }
  return b;
}
