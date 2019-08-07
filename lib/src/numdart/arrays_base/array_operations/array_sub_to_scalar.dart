import '../array.dart';

///  Multiply all the array elements for a number
///  Examples
///  --------
///  >>> var list = Array([4.0, 4.0 , 4.0]);
///  >>> arraySubToScalar(list, 2);
///  Array([2.0, 2.0, 2.0])
Array arraySubToScalar(Array a, num b) {
  var c = Array.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = a[i] - b;
  }
  return c;
}
