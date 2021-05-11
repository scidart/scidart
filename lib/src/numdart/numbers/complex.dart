import 'dart:core';

import 'package:scidart/numdart.dart';
import 'package:scidart/src/numdart/numbers/complex_operations/complex_conjugate.dart';

/// Class to create and handle a complex numbers.
///
/// # Constructors:
/// ```dart
/// Complex({this.real = 0, this.imaginary = 0}) // default constructor.
///
/// Complex.ri(this.real, this.imaginary) // constructor with
/// ```
/// # References
/// 1. "Complex number representation in Dart". https://github.com/rwl/complex. Retrieved 2019-07-15.
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
/// print(Complex());
/// print(Complex.ir(3.0, 3.0));
///
/// /* output:
/// Complex(0.0, 0.0)
/// Complex(3.0, 3.0)
/// */
/// ```
class Complex {
  final double real;
  final double imaginary;

  Complex({this.real = 0, this.imaginary = 0});

  Complex.ri(this.real, this.imaginary);

  /// Sum two complex number
  ///
  /// # Examples
  /// ```dart
  /// var c1 = Complex(real: 1, imaginary: 1);
  /// var c2 = Complex(real: 1, imaginary: 1);
  ///
  /// print(c1 + c2);
  /// /* output:
  /// Complex(real: 2.0, imaginary: 2.0);
  /// */
  /// ```
  Complex operator +(Complex b) {
    return Complex(real: real + b.real, imaginary: imaginary + b.imaginary);
  }

  /// Subtract two complex number
  ///
  /// # Examples
  /// ```dart
  /// var c1 = Complex(real: 1, imaginary: 1);
  /// var c2 = Complex(real: 1, imaginary: 1);
  ///
  /// print(c1 - c2);
  ///
  /// /* output:
  /// Complex(real: 0.0, imaginary: 0.0)
  /// */
  /// ```
  Complex operator -(Complex b) {
    return Complex(real: real - b.real, imaginary: imaginary - b.imaginary);
  }

  /// Multiply two complex number
  ///
  /// # Examples
  /// ```dart
  /// var c1 = Complex(real: 2, imaginary: 5);
  /// var c2 = Complex(real: 4, imaginary: -3);
  ///
  /// print(c1 * c2);
  ///
  /// /*output:
  /// Complex(real: 13.0, imaginary: 14.0)
  /// */
  /// ```
  Complex operator *(Complex b) {
    return Complex(
        real: real * b.real - imaginary * b.imaginary,
        imaginary: real * b.imaginary + imaginary * b.real);
  }

  /// Divide two complex number
  ///
  /// # References
  /// 1. "Python Division Of Complex Numbers Without Using Built In Types and Operators". https://stackoverflow.com/a/41146661/6846888. Retrieved 2019-07-15.
  ///
  /// # Examples
  /// ```dart
  /// var c1 = Complex(real: 1, imaginary: -3);
  /// var c2 = Complex(real: 1, imaginary: 2);
  ///
  /// print(c1 / c2);
  ///
  /// /* output:
  /// Complex(real: -1.0, imaginary: -1.0)
  /// */
  /// ```
  Complex operator /(Complex b) {
    var conjugation = complexConjugate(b);
    var denominatorRes = b * conjugation;

    // denominator has only real part
    var denominator = denominatorRes.real;
    var nominator = this * conjugation;

    return Complex(
        real: nominator.real / denominator,
        imaginary: nominator.imaginary / denominator);
  }

  /// Compare two complex number
  ///
  /// # Examples
  /// ```dart
  /// var c1 = Complex(real: 1, imaginary: -3);
  /// var c2 = Complex(real: 1, imaginary: 2);
  ///
  /// print(c1 == c2);
  ///
  /// /* output:
  /// false
  /// */
  @override
  bool operator ==(b) {
    if (b is Complex) {
      return b.real == real && b.imaginary == imaginary;
    } else {
      throw ('the right object has to be a Complex type');
    }
  }

  /// Convert a Complex object (number) to a String representation
  ///
  /// # Examples
  /// ```dart
  /// print(Complex(real: 2.0, imaginary: 2.0));
  ///
  /// var str = Complex(real: 4.0, imaginary: 4.0).toString();
  ///
  /// print(str);
  ///
  /// /* output:
  /// Complex(real: 2.0, imaginary: 2.0)
  /// Complex(real: 4.0, imaginary: 4.0)
  /// */
  /// ```
  @override
  String toString() {
    return '\n    Complex(real: $real, imaginary: $imaginary)';
  }
}
