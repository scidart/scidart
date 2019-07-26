import 'dart:core';
import 'dart:math' as math;

import 'package:scidart/numdart/fastmath/fastmath.dart' as fmath;
import 'package:scidart/numdart/geometric/hypotenuse.dart';

///  Class to create and handle a complex numbers.
///  Constructors:
///  ----------
///  Complex({this.real = 0, this.imaginary = 0}) : default constructor.
///
///  Complex.ri(this.real, this.imaginary) : constructor with
///  References
///  ----------
///  .. [1] "Complex number representation in Dart". https://github.com/rwl/complex. Retrieved 2019-07-15.
///  Examples
///  --------
///  >>> import 'package:scidart/numdart/numdart.dart';
///  >>> Complex();
///  Complex(0.0, 0.0)
///  >>> Complex.ir(3.0, 3.0);
///  Complex(3.0, 3.0)
class Complex {
  final double real;
  final double imaginary;

  Complex({this.real = 0, this.imaginary = 0});

  Complex.ri(this.real, this.imaginary);

  ///  Sum two complex number
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 1, imaginary: 1);
  ///  >>> var c2 = Complex(real: 1, imaginary: 1);
  ///  >>> c1 + c2;
  ///  >>> Complex(real: 2.0, imaginary: 2.0);
  Complex operator +(Complex b) {
    return Complex(
        real: this.real + b.real, imaginary: this.imaginary + b.imaginary);
  }

  ///  Subtract two complex number
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 1, imaginary: 1);
  ///  >>> var c2 = Complex(real: 1, imaginary: 1);
  ///  >>> c1 - c2;
  ///  >>> Complex(real: 0.0, imaginary: 0.0)
  Complex operator -(Complex b) {
    return Complex(
        real: this.real - b.real, imaginary: this.imaginary - b.imaginary);
  }

  ///  Multiply two complex number
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 2, imaginary: 5);
  ///  >>> var c2 = Complex(real: 4, imaginary: -3);
  ///  >>> c1 * c2;
  ///  >>> Complex(real: 13.0, imaginary: 14.0)
  Complex operator *(Complex b) {
    return Complex(
        real: this.real * b.real - this.imaginary * b.imaginary,
        imaginary: this.real * b.imaginary + this.imaginary * b.real);
  }

  ///  Divide two complex number
  ///  References
  ///  ----------
  ///  .. [1] "Python Division Of Complex Numbers Without Using Built In Types and Operators". https://stackoverflow.com/a/41146661/6846888. Retrieved 2019-07-15.
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 1, imaginary: -3);
  ///  >>> var c2 = Complex(real: 1, imaginary: 2);
  ///  >>> c1 / c2;
  ///  >>> Complex(real: -1.0, imaginary: -1.0)
  Complex operator /(Complex b) {
    var conjugation = b.conjugate();
    var denominatorRes = b * conjugation;

    // denominator has only real part
    var denominator = denominatorRes.real;
    var nominator = this * conjugation;

    return Complex(
        real: nominator.real / denominator,
        imaginary: nominator.imaginary / denominator);
  }

  ///  Compare two complex number
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 1, imaginary: -3);
  ///  >>> var c2 = Complex(real: 1, imaginary: 2);
  ///  >>> c1 == c2;
  ///  >>> false
  bool operator ==(b) {
    return b.real == this.real && b.imaginary == this.imaginary;
  }

  ///  Return the conjugate of a complex number
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 1, imaginary: -3);
  ///  >>> c1.conjugate();
  ///  >>> Complex(real: 1.0, imaginary: 3.0)
  Complex conjugate() {
    return Complex(real: real, imaginary: -imaginary);
  }

  ///  Return a double that represent the absolute value of a complex number
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 3.0, imaginary: 4.0);
  ///  >>> c1.abs();
  ///  >>> 5.0
  double abs() {
    return hypotenuse(real, imaginary);
  }

  ///  Divide real part and imaginary for a double number
  ///  [b] : a scalar number, can be int or double
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 4.0, imaginary: 4.0);
  ///  >>> c1.divideScalar(2);
  ///  >>> Complex(real: 2.0, imaginary: 2.0)
  Complex divideScalar(num b) {
    return Complex(real: real/b, imaginary: imaginary/b);
  }

  ///  Multiply real part and imaginary for a double number
  ///  [b] : a scalar number, can be int or double
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 2.0, imaginary: 2.0);
  ///  >>> c1.divideScalar(2);
  ///  >>> Complex(real: 4.0, imaginary: 4.0)
  Complex multiplyScalar(num b) {
    return Complex(real: real*b, imaginary: imaginary*b);
  }

  ///  Compute the [cosine](http://mathworld.wolfram.com/Cosine.html)
  ///  of this complex number.
  ///
  ///  Implements the formula:
  ///
  ///      cos(a + bi) = cos(a)cosh(b) - sin(a)sinh(b)i
  ///
  ///  Examples
  ///  --------
  ///  >>> var c1 = Complex(real: 3.0, imaginary: 4.0);
  ///  >>> c1.cos();
  ///  Complex(real: -27.034945603074224, imaginary: -3.8511533348117775)
  Complex cos() {
    return Complex(real: math.cos(real) * fmath.cosh(imaginary), imaginary: -math.sin(real) * fmath.sinh(imaginary));
  }

  ///  Convert a Complex object (number) to a String representation
  ///  Examples
  ///  --------
  ///  >>> print(Complex(real: 2.0, imaginary: 2.0));
  ///  Complex(real: 2.0, imaginary: 2.0)
  ///  >>> var str = Complex(real: 4.0, imaginary: 4.0).toString();
  ///  >>> print(str);
  ///  Complex(real: 4.0, imaginary: 4.0)
  @override
  String toString() {
    return '\n    Complex(real: ${real}, imaginary: ${imaginary})';
  }
}
