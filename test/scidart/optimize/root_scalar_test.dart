import 'dart:math' as math;

import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  // references from scipy.optimize.brentq with xtol=1e-14
  const cosRoot = 0.7390851332151612;
  const cubicRoot = 2.094551481542327;
  double cosMinusX(double x) => math.cos(x) - x;
  double cubic(double x) => x * x * x - 2 * x - 5;

  test('bracketing methods', () {
    for (var method in [RootScalarMethod.brentq, RootScalarMethod.bisect]) {
      var r = rootScalar(cosMinusX, bracket: [0.0, 1.0], method: method);
      expect(r.converged, isTrue, reason: '$method');
      expect(r.root, closeTo(cosRoot, 1e-11), reason: '$method');

      r = rootScalar(cubic, bracket: [2.0, 3.0], method: method);
      expect(r.root, closeTo(cubicRoot, 1e-11), reason: '$method');
    }
  });

  test('brentq uses fewer evaluations than bisect', () {
    var brent = rootScalar(cubic, bracket: [2.0, 3.0]);
    var bisect =
        rootScalar(cubic, bracket: [2.0, 3.0], method: RootScalarMethod.bisect);
    expect(brent.functionCalls, lessThan(bisect.functionCalls));
  });

  test('newton and secant', () {
    var r = rootScalar(cubic, x0: 2.0, fprime: (x) => 3 * x * x - 2);
    expect(r.converged, isTrue);
    expect(r.root, closeTo(cubicRoot, 1e-12));

    r = rootScalar(cosMinusX, x0: 1.0);
    expect(r.converged, isTrue);
    expect(r.root, closeTo(cosRoot, 1e-12));

    r = rootScalar((x) => math.exp(x) - 3, x0: 0.0, x1: 2.0);
    expect(r.root, closeTo(1.0986122886681098, 1e-12));
  });

  test('root at the bracket end', () {
    var r = rootScalar((x) => x - 1, bracket: [1.0, 3.0]);
    expect(r.root, 1.0);
    expect(r.iterations, 0);
  });

  test('failures are reported, not thrown', () {
    // zero derivative at the start
    var r = rootScalar((x) => x * x + 1, x0: 0.0, fprime: (x) => 2 * x);
    expect(r.converged, isFalse);
    expect(r.message, 'derivative was zero');

    // no real root: Newton keeps iterating
    r = rootScalar((x) => x * x + 1,
        x0: 0.5, fprime: (x) => 2 * x, maxIter: 20);
    expect(r.converged, isFalse);
  });

  test('invalid arguments throw', () {
    expect(() => rootScalar(cubic, bracket: [3.0, 4.0]), throwsFormatException);
    expect(() => rootScalar(cubic, method: RootScalarMethod.brentq),
        throwsFormatException);
    expect(() => rootScalar(cubic, method: RootScalarMethod.newton, x0: 1.0),
        throwsFormatException);
    expect(() => rootScalar(cubic), throwsFormatException);
  });
}
