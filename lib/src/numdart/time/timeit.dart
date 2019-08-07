///  Return the time necessary to compute a function.
///  Examples
///  --------
///  >>> var duration = timeit(() {
///    var xx = arrayToComplexArray(Array([0, 0, 0, 0, 1, 1, 1, 1]));
///    var xf = fft(xx);
///  });
Duration timeit(Function function) {
  final stopwatch = Stopwatch()..start();
  function();
  stopwatch.stop();
  return stopwatch.elapsed;
}
