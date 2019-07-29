//#region array operations
import 'dart:math' as math;

import 'package:scidart/numdart/array/array.dart';
import 'package:scidart/numdart/array/arrayComplex.dart';
import 'package:scidart/numdart/numbers/complex.dart';
import 'package:scidart/numdart/numbers/double.dart';

import '../../numdart.dart';

///  Multiply all the array elements for a number
///  Examples
///  --------
///  >>> var list = Array([4.0, 4.0 , 4.0]);
///  >>> arrayMultiplyToScalar(list, 2);
///  Array([4.0, 4.0, 4.0])
Array arrayMultiplyToScalar(Array a, num b) {
  var c = Array.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = a[i] * b;
  }
  return c;
}

///  Divide all the array elements for a number
///  Examples
///  --------
///  >>> var list = Array([4.0, 8.0 , 16.0]);
///  >>> arrayDivisionToScalar(list, 2);
///  Array([2.0, 4.0, 8.0])
Array arrayDivisionToScalar(Array a, num b) {
  var c = Array.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = a[i] / b;
  }
  return c;
}

///  Convert a Array to ArrayComplex
///  Examples
///  --------
///  >>> var list = Array([1.0, 2.0 , 3.0]);
///  >>> arrayToComplexArray(list);
///  ArrayComplex([Complex(real: 1.0, imaginary: 0.0), Complex(real: 2.0, imaginary: 0.0) , Complex(real: 3.0, imaginary: 0.0)])
ArrayComplex arrayToComplexArray(Array a) {
  var c = ArrayComplex.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = Complex(real: a[i]);
  }
  return c;
}

///  Compute the cos for each element of the array
///  Examples
///  --------
///  >>> var n = Array([0.5*pi, pi, (3/2)*pi, 2*pi]);
///  >>> var cosn = arrayCos(n);
///  Array([6.123233995736766e-17, -1.0, -1.8369701987210297e-16, 1.0])
Array arrayCos(Array a) {
  var c = Array.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = math.cos(a[i]); //fixme change to fast cos in the future
  }
  return c;
}

///  Compute the square root for each element of the array
///  Examples
///  --------
///  >>> var n = Array([4, 4, 4]);
///  >>> arraySqrt(n);
///  Array([2, 2, 2])
Array arraySqrt(Array a) {
  var c = Array.fixed(a.length);
  for (int i = 0; i < a.length; i++) {
    c[i] = math.sqrt(a[i]);
  }
  return c;
}

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

///  Truncate all the numbers of the array
///  Examples
///  --------
///  >>> var n = Array([4.123456789, 4.123456789, 4.123456789]);
///  >>> arrayTruncateEachElement(n, 4);
///  Array([4.1235, 4.1235, 4.1235])
dynamic arrayTruncateEachElement(Array a, int fractionDigits,
    {bool returnNewArray = false}) {
  if (returnNewArray) {
    var b = Array.fixed(a.length);
    for (var i = 0; i < a.length; i++) {
      b[i] = truncate(a[i], fractionDigits);
    }
    return b;
  } else {
    for (var i = 0; i < a.length; i++) {
      a[i] = truncate(a[i], fractionDigits);
    }
  }
}

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
//#endregion

//#region vector operations
///  Convert a Array to a matrix with one column
///  Examples
///  --------
///  >>> var n = Array([4.0, 4.0, 4.0]);
///  >>> arrayToColumnMatrix(n);
///  Array2d([
///    Array([4.0]),
///    Array([4.0]),
///    Array([4.0])
///  ])
Array2d arrayToColumnMatrix(Array a) {
  var b = Array2d.fixed(a.length, 1);
  for (var i = 0; i < a.length; i++) {
    b[i][0] = a[i];
  }
  return b;
}

///  Concatenate a and b and return
///  Examples
///  >>> var list = Array([1,2,3]);
///  >>> var b = Array([4]);
///  >>> arrayConcat(a, b);
///  Array([1, 2, 3, 4])
Array arrayConcat(Array a, Array b) {
  Array c = Array.empty();
  for (int i = 0; i < a.length; i++) {
    c.add(a[i]);
  }
  for (int i = 0; i < b.length; i++) {
    c.add(b[i]);
  }
  return c;
}

/////  Concatenate  in to the start current array
/////  Examples
/////  >>> var list = Array([1,2,3]);
/////  >>> var b = Array([4]);
/////  >>> list.concat(b);
/////  Array([4, 1, 2, 3,])
//void arrayConcatStart(Array a, Array b) {
//  var aux = this.copy();
//  this.l = x.copy();
//  this.concat(aux);
//}

///  Add zeros at begging of the array
///  Examples
///  >>> var list = Array([1,2,3]);
///  >>> arrayPadStart(list, 2)
///  Array([0, 0, 1, 2, 3])
Array arrayPadStart(Array a, int pad) {
  var aux = Array.fixed(pad, initialValue: 0);
  return arrayConcat(aux, a);
}
//#endregion
