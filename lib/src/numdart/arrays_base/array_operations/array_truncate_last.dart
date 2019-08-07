import '../array.dart';

///  Return a Array without the last element
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> arrayTruncateLast(n);
///  Array([1.0, 2.0])
Array arrayTruncateLast(Array a) {
  var c = Array.fixed(a.length - 1);
  for (int i = 0; i < c.length; i++) {
    c[i] = a[i];
  }
  return c;
}
