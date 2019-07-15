import 'dart:math';

///  Calculate the hypotenuse with pythagorean theorem
///  [x] : cathetus X
///  [y] : cathetus Y
///  Examples
///  --------
///  >>> truncate(1.4747474747474747, 3);
///  >>> 1.475;
double pythagoras(double x, double y) {
  return sqrt(pow(x, 2) + pow(y, 2));
}