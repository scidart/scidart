import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('polynomial', () {
    // some point to estimate a polynomial regression
    var y = Array([0, 1, 4, 3, 2, 5, 0]); // y axis points
    var x = Array([0, 1, 2, 3, 4, 5, 6]); // x axis points
    var degree = 10; // suggested polynomial degree

    var p = PolyFit(x, y, degree); // polynomial regression
    print(p); // print polynomial

    // print the current polynomial degree, the function reduces the degree
    // to get the ideal degree rank for the actual points
    print(p.polyDegree());

    print(p.coefficients()); // polynomial coefficients

    print(p.predict(3.5)); // estimate a y value for the point x = 3.5
  });
}
