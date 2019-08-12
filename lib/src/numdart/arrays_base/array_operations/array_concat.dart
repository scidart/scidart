import '../array.dart';

///  Concatenate a and b and return
///  Examples
///  >>> var list = Array([1,2,3]);
///  >>> var b = Array([4]);
///  >>> arrayConcat(a, b);
///  Array([1, 2, 3, 4])
Array arrayConcat(Array a, Array b) {
  //todo convert to acecpt N arguments
  Array c = Array.empty();
  for (int i = 0; i < a.length; i++) {
    c.add(a[i]);
  }
  for (int i = 0; i < b.length; i++) {
    c.add(b[i]);
  }
  return c;
}
