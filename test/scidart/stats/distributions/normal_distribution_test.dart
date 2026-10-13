import 'dart:math' as math;

import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

Matcher closeToRelative(double expected, [double tolerance = 1e-12]) =>
    closeTo(expected, expected.abs() * tolerance + 1e-300);

void main() {
  // references from scipy.stats.norm(loc=10, scale=2)
  var n = NormalDistribution(mean: 10.0, std: 2.0);
  var xs = <double>[-5.0, 4.0, 9.0, 10.0, 12.0, 15.5, 30.0];
  var ps = <double>[
    1e-300,
    1e-20,
    1e-10,
    1e-05,
    0.001,
    0.02425,
    0.1,
    0.3,
    0.5,
    0.7,
    0.975,
    0.999,
    0.9999999999
  ];

  void expectAll(
      double Function(double) f, List<double> input, List<double> expected) {
    for (var i = 0; i < input.length; i++) {
      expect(f(input[i]), closeToRelative(expected[i]),
          reason: 'input ${input[i]}');
    }
  }

  test('pdf and logPdf', () {
    expectAll(n.pdf, xs, [
      1.217160266514505e-13,
      0.0022159242059690038,
      0.17603266338214976,
      0.19947114020071635,
      0.12098536225957168,
      0.0045467812507955264,
      3.84729931335321e-23
    ]);
    expectAll(n.logPdf, xs, [
      -29.737085713764618,
      -6.112085713764618,
      -1.737085713764618,
      -1.612085713764618,
      -2.112085713764618,
      -5.393335713764618,
      -51.61208571376462
    ]);
  });

  test('cdf and sf', () {
    expectAll(n.cdf, xs, [
      3.1908916729108844e-14,
      0.001349898031630093,
      0.3085375387259869,
      0.5,
      0.8413447460685429,
      0.9970202367649454,
      1.0
    ]);
    expectAll(n.sf, xs, [
      0.9999999999999681,
      0.9986501019683699,
      0.6914624612740131,
      0.5,
      0.15865525393145707,
      0.002979763235054555,
      7.619853024160474e-24
    ]);
  });

  test('ppf and isf', () {
    expectAll(n.ppf, ps, [
      -64.0941925987224,
      -8.524680179596817,
      -2.7226818048081114,
      1.4702184121543507,
      3.8195353876643736,
      6.05407789737623,
      7.436896868910799,
      8.951198974583917,
      10.0,
      11.048801025416081,
      13.919927969080108,
      16.180464612335626,
      22.722681779394843
    ]);
    expectAll(n.isf, ps, [
      84.0941925987224,
      28.524680179596817,
      22.72268180480811,
      18.529781587845648,
      16.180464612335626,
      13.94592210262377,
      12.5631031310892,
      11.048801025416083,
      10.0,
      8.951198974583919,
      6.080072030919892,
      3.8195353876643736,
      -2.7226817793948435
    ]);
  });

  test('ppf limits and invalid probabilities', () {
    expect(n.ppf(0.0), double.negativeInfinity);
    expect(n.ppf(1.0), double.infinity);
    expect(() => n.ppf(-0.1), throwsFormatException);
    expect(() => n.ppf(1.1), throwsFormatException);
    expect(() => n.ppf(double.nan), throwsFormatException);
  });

  test('ppf inverts cdf', () {
    for (var x in [-3.0, 0.0, 7.5, 10.0, 14.2, 20.0]) {
      expect(n.ppf(n.cdf(x)), closeTo(x, 1e-9));
    }
  });

  test('moments and interval', () {
    expect(n.variance, 4.0);
    var i = n.interval(0.95);
    expect(i[0], closeToRelative(6.080072030919892));
    expect(i[1], closeToRelative(13.919927969080108));
  });

  test('standard normal defaults', () {
    var z = NormalDistribution();
    expect(z.pdf(0.0), closeToRelative(0.3989422804014327));
    expect(z.cdf(1.959963984540054), closeToRelative(0.975));
  });

  test('array versions', () {
    var a = Array([9.0, 10.0]);
    expect(n.pdfArray(a)[1], closeToRelative(0.19947114020071635));
    expect(n.cdfArray(a)[0], closeToRelative(0.3085375387259869));
    expect(n.ppfArray(Array([0.5]))[0], 10.0);
  });

  test('sample has the expected mean and std', () {
    var s = n.sample(20001, random: math.Random(42));
    expect(s.length, 20001);
    expect(mean(s), closeTo(10.0, 0.05));
    expect(standardDeviation(s), closeTo(2.0, 0.05));
    // same seed, same samples
    expect(n.sample(5, random: math.Random(1)),
        n.sample(5, random: math.Random(1)));
  });

  test('invalid parameters', () {
    expect(() => NormalDistribution(std: 0.0), throwsFormatException);
    expect(() => NormalDistribution(std: -1.0), throwsFormatException);
    expect(() => NormalDistribution(mean: double.nan), throwsFormatException);
    expect(() => n.sample(-1), throwsFormatException);
  });
}
