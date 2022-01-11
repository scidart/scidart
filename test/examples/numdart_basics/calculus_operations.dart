import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('calculus operations', () {
    var y = Array([-1, -1, -1, -1, 1, 1, 1, 1]); // function y points
    var x = arange(stop: 8); // function x points

    // array integration
    print(trapzArray(y, x: x)); // integration with trapezoidal rule
    print(simpsArray(y, x: x)); // integration with Simpson's rule

    // cumulative integration using trapezoidal rule, useful for signals
    print(cumIntegration(y, x: x));

    // function integration
    var f = (x) => pow(x, 2); // function definition: y = x^2
    var a = 0.0; // start integration interval
    var b = 10.0; // end integration interval
    var n = 10; // number of point between a and b
    print(trapzFunction(a, b, n, f)); // integration using trapezoidal rule
    print(simpsFunction(a, b, n, f)); // integration using Simpson's rule

    // array differentiation
    print(differentiateArray(y, x)); // return an array with the differentiation

    // function differentiation
    var px = 10.0; // point where the function will be differentiated
    print(differentiateFunction(
        px, f)); // return the differentiation at point x=10.0
  });
}
