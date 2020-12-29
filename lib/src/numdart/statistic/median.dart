import 'package:scidart/src/numdart/arrays_base/array.dart';

///  Return the median of a array
///  Examples
///  --------
///  >>> var n = Array([1, 2, 3]);
///  >>> median(n);
///  2.0
double median(Array a) {
  var middle = a.length ~/ 2;
  if (a.length % 2 == 1) {
    return a[middle];
  } else {
    return (a[middle - 1] + a[middle]) / 2.0;
  }
}
