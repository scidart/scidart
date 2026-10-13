import 'package:scidart/src/numdart/numdart.dart';

/// Result of [root]: the solution and how the solver ended.
class OptimizeResult {
  /// The solution, or the last iterate when [success] is false.
  final Array x;

  /// Value of the function at [x].
  final Array fun;

  /// Whether the solver found a root within the tolerance.
  final bool success;

  /// Number of iterations done.
  final int iterations;

  /// Number of evaluations of the function, including the ones used to
  /// approximate the Jacobian.
  final int functionCalls;

  /// Why the solver stopped.
  final String message;

  OptimizeResult({
    required this.x,
    required this.fun,
    required this.success,
    required this.iterations,
    required this.functionCalls,
    required this.message,
  });

  @override
  String toString() =>
      'OptimizeResult(success: $success, x: ${x.toList()}, iterations: '
      '$iterations, functionCalls: $functionCalls, message: $message)';
}

/// Result of [rootScalar]: the root and how the solver ended.
class RootScalarResult {
  /// The root, or the last iterate when [converged] is false.
  final double root;

  /// Whether the solver converged within the tolerance.
  final bool converged;

  /// Number of iterations done.
  final int iterations;

  /// Number of evaluations of the function (and of its derivative, for
  /// Newton).
  final int functionCalls;

  /// Why the solver stopped.
  final String message;

  RootScalarResult({
    required this.root,
    required this.converged,
    required this.iterations,
    required this.functionCalls,
    required this.message,
  });

  @override
  String toString() =>
      'RootScalarResult(converged: $converged, root: $root, iterations: '
      '$iterations, functionCalls: $functionCalls, message: $message)';
}
