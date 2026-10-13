import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

Array2d rows(List<List<double>> values) =>
    Array2d(values.map((r) => Array(r)).toList());

void main() {
  test('terms follow sklearn PolynomialFeatures order', () {
    var x = rows([
      [0, 0, 0],
      [1, 2, 3],
    ]);
    var p = PolyFitMultivariate(
        x,
        rows([
          [0],
          [1]
        ]),
        3);
    // PolynomialFeatures(3).powers_ for 3 features
    expect(p.powers, [
      [0, 0, 0], [1, 0, 0], [0, 1, 0], [0, 0, 1], [2, 0, 0], [1, 1, 0], //
      [1, 0, 1], [0, 2, 0], [0, 1, 1], [0, 0, 2], [3, 0, 0], [2, 1, 0], //
      [2, 0, 1], [1, 2, 0], [1, 1, 1], [1, 0, 2], [0, 3, 0], [0, 2, 1], //
      [0, 1, 2], [0, 0, 3],
    ]);
  });

  test('exact fit with 3 features and 2 outputs', () {
    var x = rows([
      [0.5, 1.589, 1.103],
      [-1.099, -0.799, 1.494],
      [-1.979, 1.285, 1.188],
      [-0.128, -0.788, -0.886],
      [-0.981, -0.22, 0.018],
      [0.214, 1.982, 1.171],
      [0.489, 1.956, -1.139],
      [-1.359, 0.45, -1.824],
      [-1.857, 0.06, -0.135],
      [1.669, 0.517, 0.056],
      [-0.013, -1.01, -1.953],
      [-1.23, 0.768, -1.198]
    ]);
    // y0 = 1 + 2 x0 - x1 x2 + 0.5 x0^2, y1 = 3 - x2 + x0 x1
    var y = Array2d(x
        .map((r) => Array([
              1 + 2 * r[0] - r[1] * r[2] + 0.5 * r[0] * r[0],
              3 - r[2] + r[0] * r[1],
            ]))
        .toList());

    var p = PolyFitMultivariate(x, y, 2);

    // terms: 1, x0, x1, x2, x0^2, x0x1, x0x2, x1^2, x1x2, x2^2
    var expected = [
      [1.0, 2.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, -1.0, 0.0],
      [3.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0],
    ];
    expect(p.rank, 10);
    for (var o = 0; o < 2; o++) {
      for (var t = 0; t < 10; t++) {
        expect(p.coefficients[t][o], closeTo(expected[o][t], 1e-10),
            reason: 'output $o term $t');
      }
      expect(p.R2()[o], closeTo(1.0, 1e-12));
    }
    var out = p.predict(Array([1.0, 2.0, 3.0]));
    expect(out[0], closeTo(1 + 2 - 6 + 0.5, 1e-10));
    expect(out[1], closeTo(3 - 3 + 2, 1e-10));
    expect(
        p.predictAll(rows([
          [1.0, 2.0, 3.0]
        ]))[0],
        out);
  });

  test('noisy data matches sklearn LinearRegression', () {
    var x = rows([
      [-0.3992, 0.7482],
      [0.3244, -0.7368],
      [0.6901, 0.8899],
      [0.8078, 0.1394],
      [-0.7091, -0.6151],
      [0.8558, 0.1047],
      [-0.6389, 0.7681],
      [0.2831, 0.1394],
      [-0.2474, -0.1781],
      [-0.521, -0.9239],
      [0.7524, -0.0645],
      [0.0953, -0.3557],
      [0.5026, -0.9496],
      [-0.2556, -0.9393],
      [-0.7542, 0.9343],
      [0.3155, -0.1436],
      [0.0475, 0.7456],
      [-0.3116, 0.1806],
      [0.3674, -0.2892],
      [0.0382, 0.5305],
      [0.8184, -0.6979],
      [0.8668, -0.9896],
      [0.506, 0.6211],
      [-0.7265, -0.1622],
      [0.6305, -0.9715],
      [0.2569, 0.586],
      [0.026, 0.4517],
      [-0.5472, -0.603],
      [-0.2737, -0.6412],
      [-0.3079, 0.8962]
    ]);
    var y = Array2d([
      1.746118084920471,
      2.449975420247068,
      3.336068785660572,
      1.9247527303508711,
      1.0565506213197176,
      1.9097042553094012,
      1.4999818369313211,
      1.2273095892099044,
      0.8614367678367248,
      2.0948591683398075,
      1.6638508134482493,
      1.2862144577550874,
      3.4011179760933405,
      2.5806503663386384,
      2.0864658570263126,
      1.362102288199307,
      2.2539687287687413,
      0.763851910507676,
      1.61946071970321,
      1.700968937696815,
      2.8894021529490894,
      3.8139932287177776,
      2.3759084768883394,
      0.3968473028097951,
      3.5268393080694804,
      1.868483363073808,
      1.520306202724334,
      1.169721423801197,
      1.6484617357006315,
      2.3232251835111484
    ].map((v) => Array([v])).toList());

    var p = PolyFitMultivariate(x, y, 2);

    // PolynomialFeatures(2) + LinearRegression(fit_intercept=False)
    var coef = [
      1.0192456048488725,
      1.0092188827030988,
      0.013791583175455563,
      -0.009428551114697993,
      -0.005960414081465195,
      2.027291347918074
    ];
    for (var t = 0; t < coef.length; t++) {
      expect(p.coefficients[t][0], closeTo(coef[t], 1e-10), reason: 'term $t');
    }
    expect(p.R2()[0], closeTo(0.9943188311419188, 1e-10));
  });

  test('more terms than samples uses the minimum norm solution, issue #55', () {
    // 7 samples, 5 features, 2 outputs, degree 2: 21 terms
    var x = rows([
      [3.7, 0.04, 8.3, 1.54, 2.68],
      [8.8, 5.1, 8.47, 6.4, 7.42],
      [0.91, 5.41, 5.08, 8.71, 3.61],
      [5.98, 0.59, 3.88, 3.23, 1.5],
      [8.16, 3.79, 9.79, 5.9, 6.05],
      [6.38, 6.76, 1.51, 4.4, 2.4],
      [4.02, 0.97, 9.68, 2.15, 6.72]
    ]);
    var y = rows([
      [0, 1],
      [1, 6],
      [4, 11],
      [0, 2],
      [0, 5],
      [3, 7],
      [12, 15]
    ]);

    var p = PolyFitMultivariate(x, y, 2);

    expect(p.powers.length, 21);
    expect(p.rank, 7);
    // interpolates the samples
    for (var i = 0; i < x.length; i++) {
      var out = p.predict(x[i]);
      expect(out[0], closeTo(y[i][0], 1e-8));
      expect(out[1], closeTo(y[i][1], 1e-8));
    }
    // numpy.linalg.lstsq on the scaled terms, like numpy.polyfit
    var out = p.predict(Array([5, 5, 5, 5, 5]));
    expect(out[0], closeTo(3.218299988205736, 1e-8));
    expect(out[1], closeTo(7.071768273232476, 1e-8));
  });

  test('degree 0 is the mean', () {
    var p = PolyFitMultivariate(
        rows([
          [1, 2],
          [3, 4],
          [5, 6]
        ]),
        rows([
          [1],
          [2],
          [6]
        ]),
        0);
    expect(p.predict(Array([0, 0]))[0], closeTo(3.0, 1e-12));
  });

  test('invalid arguments throw', () {
    var x = rows([
      [1, 2],
      [3, 4]
    ]);
    var y = rows([
      [1],
      [2]
    ]);
    expect(() => PolyFitMultivariate(x, y, -1), throwsFormatException);
    expect(
        () => PolyFitMultivariate(
            x,
            rows([
              [1]
            ]),
            1),
        throwsFormatException);
    expect(() => PolyFitMultivariate(Array2d.empty(), Array2d.empty(), 1),
        throwsFormatException);
    expect(
        () => PolyFitMultivariate(
            rows([
              [1, double.nan],
              [3, 4]
            ]),
            y,
            1),
        throwsFormatException);
    expect(
        () => PolyFitMultivariate(
            rows([
              [1e200, 2],
              [3, 4]
            ]),
            y,
            2),
        throwsFormatException);
    expect(() => PolyFitMultivariate(x, y, 1).predict(Array([1])),
        throwsFormatException);
  });

  test('columns near the largest double keep their scale', () {
    // the column norm of x overflows although every value is finite
    var xs = [1.0e308, 1.5e308, 0.5e308, 1.2e308];
    var x = rows([
      for (var v in xs) [v]
    ]);
    var y = rows([
      for (var v in xs) [2.0 + 3e-308 * v]
    ]);
    var fit = PolyFitMultivariate(x, y, 1);
    expect(fit.rank, 2);
    expect(fit.coefficients[0][0], closeTo(2.0, 1e-12));
    expect(fit.coefficients[1][0], closeTo(3e-308, 3e-320));
    expect(fit.predict(Array([0.8e308]))[0], closeTo(4.4, 1e-12));
  });
}
