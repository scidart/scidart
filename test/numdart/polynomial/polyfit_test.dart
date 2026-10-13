import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('polyfit simple', () {
    const degree = 2;
    var x = Array([0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]);
    var y = Array(
        [1.0, 6.0, 17.0, 34.0, 57.0, 86.0, 121.0, 162.0, 209.0, 262.0, 321.0]);

    var p = PolyFit(x, y, degree);
    var coef = p.coefficients();
    arrayTruncateEachElement(coef, 4);

    print(p);
    print(coef);

    var coefExpect = Array([3.0, 2.0, 1.0]);
    arrayTruncateEachElement(coefExpect, 4);

    expect(coef, coefExpect);
  });

  test('predict', () {
    const degree = 2;
    var x = Array([0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]);
    var y = Array(
        [1.0, 6.0, 17.0, 34.0, 57.0, 86.0, 121.0, 162.0, 209.0, 262.0, 321.0]);

    var p = PolyFit(x, y, degree);
    var pred = truncate(p.predict(1.0), 4);
    print(pred);

    var predExpect = 6.0;

    expect(pred, predExpect);
  });

  test('predict issue #16', () {
    var ar = [
      [0.01, 0.012],
      [0.02, 0.024],
      [0.03, 0.040],
      [0.04, 0.050],
      [0.05, 0.062],
      [0.06, 0.075],
      [0.07, 0.091],
      [0.08, 0.099],
      [0.09, 0.115]
    ];

    var x = Array.empty();
    var y = Array.empty();
    var n = ar.length;
    for (var i = 0; i < n; i++) {
      x.add(ar[i][0]);
      y.add(ar[i][1]);
    }
    const deg = 3;
    var eq = PolyFit(x, y, deg);
    print(eq);

    expect(eq.polyDegree(), deg);
  });

  test('predict issue #37', () {
    var x = Array([7614, 7614, 7614, 7980, 7980, 7980, 7980]);
    var y = Array([1, 4, 20, 25, 25, 20, 4]);
    var deg = 5;

    // only two distinct x values: the degree is reduced to a line
    var eq = PolyFit(x, y, deg);
    expect(eq.polyDegree(), 1);
  });

  test('predict issue #37 working', () {
    var x = Array([1, 4, 20, 25, 25, 20, 4]);
    var y = Array([7614, 7614, 7614, 7980, 7980, 7980, 7980]);
    var deg = 5;

    var eq = PolyFit(x, y, deg);
    print(eq);

    // only four distinct x values: the degree is reduced to 3, with the same
    // residuals numpy.polyfit gives for deg=5
    expect(eq.polyDegree(), 3);
    expect(eq.R2(), closeTo(0.4166666666666667, 1e-9));
  });

  test('third order fit, issue #58', () {
    var x = Array([100.0, 200, 300, 400, 500, 600, 700]);
    var y = Array(x.map((v) => 0.5 * v * v * v - v * v + 3 * v + 1).toList());

    var eq = PolyFit(x, y, 3);

    expect(eq.polyDegree(), 3);
    expect(eq.coefficient(3), closeTo(0.5, 1e-9));
    expect(eq.coefficient(2), closeTo(-1.0, 1e-6));
    expect(eq.R2(), closeTo(1.0, 1e-12));
  });

  test('infinite values throw instead of looping, issue #65', () {
    var x = Array([80, 90, 100]);
    var y = Array([double.infinity, 0, 1]);

    for (var deg = 0; deg <= 4; deg++) {
      expect(() => PolyFit(x, y, deg), throwsFormatException);
    }
    expect(() => PolyFit(Array([double.nan, 1, 2]), Array([0, 1, 2]), 1),
        throwsFormatException);
  });
}
