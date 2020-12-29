import '../array.dart';

///  Divide all the array elements for a number
///  Examples
///  --------
///  >>> var list = Array([4.0, 8.0 , 16.0]);
///  >>> arrayDivisionToScalar(list, 2);
///  Array([2.0, 4.0, 8.0])
Array arrayDivisionToScalar(Array a, num b) {
  var c = Array.fixed(a.length);
  for (var i = 0; i < a.length; i++) {
    c[i] = a[i] / b;
  }
  return c;
}
