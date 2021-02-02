import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a linear space 50 elem', () {
    var n = linspace(1.2, 3);

    var nExpect = [
      1.2,
      1.23673469,
      1.27346939,
      1.31020408,
      1.34693878,
      1.38367347,
      1.42040816,
      1.45714286,
      1.49387755,
      1.53061224,
      1.56734694,
      1.60408163,
      1.64081633,
      1.67755102,
      1.71428571,
      1.75102041,
      1.7877551,
      1.8244898,
      1.86122449,
      1.89795918,
      1.93469388,
      1.97142857,
      2.00816327,
      2.04489796,
      2.08163265,
      2.11836735,
      2.15510204,
      2.19183673,
      2.22857143,
      2.26530612,
      2.30204082,
      2.33877551,
      2.3755102,
      2.4122449,
      2.44897959,
      2.48571429,
      2.52244898,
      2.55918367,
      2.59591837,
      2.63265306,
      2.66938776,
      2.70612245,
      2.74285714,
      2.77959184,
      2.81632653,
      2.85306122,
      2.88979592,
      2.92653061,
      2.96326531,
      3.0
    ];

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });

  test('create a linear space with 50 elemets but without endpoint', () {
    var n = linspace(1.2, 3, endpoint: false);

    var nExpect = [
      1.2,
      1.236,
      1.272,
      1.308,
      1.344,
      1.38,
      1.416,
      1.452,
      1.488,
      1.524,
      1.56,
      1.596,
      1.632,
      1.668,
      1.704,
      1.74,
      1.776,
      1.812,
      1.848,
      1.884,
      1.92,
      1.956,
      1.992,
      2.028,
      2.064,
      2.1,
      2.136,
      2.172,
      2.208,
      2.244,
      2.28,
      2.316,
      2.352,
      2.388,
      2.424,
      2.46,
      2.496,
      2.532,
      2.568,
      2.604,
      2.64,
      2.676,
      2.712,
      2.748,
      2.784,
      2.82,
      2.856,
      2.892,
      2.928,
      2.964
    ];

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });

  test('create a linear space with 3 elements', () {
    var n = linspace(1.2, 3, num: 3);

    var nExpect = [1.2, 2.1, 3.0];

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });

  test('create a linear space with 3 elements without end point', () {
    var n = linspace(1.2, 3, num: 3, endpoint: false);

    var nExpect = [1.2, 1.8, 2.4];

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });
}
