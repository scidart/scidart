Duration timeit(Function function) {
  final stopwatch = Stopwatch()..start();
  function();
  stopwatch.stop();
  return stopwatch.elapsed;
}
