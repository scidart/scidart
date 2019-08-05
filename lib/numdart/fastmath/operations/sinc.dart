import 'dart:math';

///  compute nomilized sinc function of x
double sinc(double x) {
  var y;
  if (x == 0) {
    y = 1.0e-20;
  } else {
    y = x;
  }

  y = pi * y;

  return sin(y) / y;
}
