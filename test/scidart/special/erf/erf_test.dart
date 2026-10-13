import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

/// Relative comparison, absolute near zero.
Matcher closeToRelative(double expected, [double tolerance = 1e-14]) =>
    closeTo(expected, expected.abs() * tolerance + 1e-300);

void main() {
  // scipy.special.erf and scipy.special.erfc
  var xs = <double>[
    -30.0,
    -6.0,
    -3.5,
    -1.0,
    -0.4,
    -1e-20,
    0.0,
    1e-10,
    0.3,
    0.46875,
    0.5,
    1.0,
    2.0,
    3.0,
    3.99,
    4.0,
    5.5,
    10.0,
    26.0,
    27.0
  ];
  var erfRef = <double>[
    -1.0,
    -1.0,
    -0.9999992569016276,
    -0.8427007929497148,
    -0.42839235504666845,
    -1.1283791670955125e-20,
    0.0,
    1.1283791670955126e-10,
    0.3286267594591274,
    0.492613473217938,
    0.5204998778130465,
    0.8427007929497148,
    0.9953222650189527,
    0.9999779095030014,
    0.9999999832607886,
    0.9999999845827421,
    0.9999999999999927,
    1.0,
    1.0,
    1.0
  ];
  var erfcRef = <double>[
    2.0,
    2.0,
    1.9999992569016276,
    1.8427007929497148,
    1.4283923550466684,
    1.0,
    1.0,
    0.999999999887162,
    0.6713732405408726,
    0.507386526782062,
    0.4795001221869535,
    0.15729920705028516,
    0.004677734981047266,
    2.2090496998585445e-05,
    1.6739211364520817e-08,
    1.541725790028002e-08,
    7.357847917974397e-15,
    2.0884875837625446e-45,
    5.663192408856145e-296,
    0.0
  ];

  test('erf matches scipy', () {
    for (var i = 0; i < xs.length; i++) {
      expect(erf(xs[i]), closeToRelative(erfRef[i]), reason: 'x = ${xs[i]}');
    }
  });

  test('erfc matches scipy', () {
    for (var i = 0; i < xs.length; i++) {
      expect(erfc(xs[i]), closeToRelative(erfcRef[i]), reason: 'x = ${xs[i]}');
    }
  });

  test('erf special values', () {
    expect(erf(double.infinity), 1.0);
    expect(erf(double.negativeInfinity), -1.0);
    expect(erfc(double.infinity), 0.0);
    expect(erf(double.nan).isNaN, isTrue);
  });

  test('array erf and erfc', () {
    var a = Array([0.0, 0.5, 3.0]);
    expect(arrayErf(a)[1], closeToRelative(0.5204998778130465));
    expect(arrayErfc(a)[2], closeToRelative(2.2090496998585445e-05));
  });

  test('erfc keeps the subnormal tail', () {
    // mpmath.erfc with 50 digits; a subnormal result keeps fewer bits, so the
    // tolerance is about one unit of the smallest subnormal (4.9e-324)
    expect(erfc(26.6), closeTo(1.0885125885442265e-309, 1e-322));
    expect(erfc(27.0), closeTo(5.2370489237892557e-319, 1e-323));
    expect(erfc(27.2), closeTo(1.0189049142703155e-323, 5e-324));
    expect(erfc(-27.0), 2.0);
    // erfc(27.25) = 6.7e-325 rounds to zero
    expect(erfc(27.25), 0.0);
    expect(erfc(1e300), 0.0);
  });
}
