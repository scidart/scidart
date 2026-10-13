import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  // example of the scipy.optimize.root documentation; hybr gives
  // [0.8411639019140097, 0.15883609808599036]
  Array docSystem(Array v) => Array([
        v[0] + 0.5 * (v[0] - v[1]) * (v[0] - v[1]) * (v[0] - v[1]) - 1.0,
        0.5 * (v[1] - v[0]) * (v[1] - v[0]) * (v[1] - v[0]) + v[1],
      ]);

  // roots are the permutations of (1, 2, 3)
  Array symmetric(Array v) => Array([
        v[0] + v[1] + v[2] - 6,
        v[0] * v[1] + v[1] * v[2] + v[2] * v[0] - 11,
        v[0] * v[1] * v[2] - 6,
      ]);

  test('2x2 system with every method', () {
    for (var method in RootMethod.values) {
      var r = root(docSystem, Array([0.0, 0.0]), method: method);
      expect(r.success, isTrue, reason: '$method ${r.message}');
      expect(r.x[0], closeTo(0.8411639019140097, 1e-9), reason: '$method');
      expect(r.x[1], closeTo(0.15883609808599036, 1e-9), reason: '$method');
    }
  });

  test('3x3 system with every method', () {
    for (var method in RootMethod.values) {
      var r = root(symmetric, Array([0.8, 2.3, 3.4]), method: method);
      expect(r.success, isTrue, reason: '$method ${r.message}');
      var sorted = r.x.toList()..sort();
      expect(sorted[0], closeTo(1, 1e-8), reason: '$method');
      expect(sorted[1], closeTo(2, 1e-8), reason: '$method');
      expect(sorted[2], closeTo(3, 1e-8), reason: '$method');
      for (var v in r.fun) {
        expect(v.abs(), lessThanOrEqualTo(1e-10), reason: '$method');
      }
    }
  });

  test('analytic Jacobian saves function calls', () {
    Array2d jac(Array v) => Array2d([
          Array([2 * v[0], 2 * v[1]]),
          Array([1.0, -1.0]),
        ]);
    Array circle(Array v) =>
        Array([v[0] * v[0] + v[1] * v[1] - 4, v[0] - v[1]]);

    var numeric = root(circle, Array([1.0, 0.5]), method: RootMethod.newton);
    var analytic = root(circle, Array([1.0, 0.5]),
        method: RootMethod.newton, jacobian: jac);
    expect(analytic.success, isTrue);
    expect(analytic.x[0], closeTo(1.4142135623730951, 1e-12));
    expect(analytic.functionCalls, lessThan(numeric.functionCalls));
  });

  test('a system without root is reported as failure', () {
    for (var method in RootMethod.values) {
      var r = root((v) => Array([v[0] * v[0] + 1]), Array([1.0]),
          method: method, maxIter: 50);
      expect(r.success, isFalse, reason: '$method');
      expect(r.message, isNot('converged'));
    }
  });

  test('invalid arguments throw', () {
    expect(() => root(symmetric, Array.empty()), throwsFormatException);
    expect(() => root((v) => Array([v[0]]), Array([1.0, 2.0])),
        throwsFormatException);
  });
}
