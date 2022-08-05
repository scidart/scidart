import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('complex concat duration', () async {
    final sr = 48000;
    final x = arrayToComplexArray(ones(sr * 5));
    final s = Stopwatch();
    s.start();
    final y = arrayComplexConcat(x, x);
    final elapsed = s.elapsedMilliseconds / 1000; // elapsed seconds
    expect(elapsed, lessThan(1));
    expect(y.length, sr * 10);
  });

  test('complex concat values', () async {
    final sr = 1;
    final x1 = arrayToComplexArray(ones(sr * 5));
    final x2 = arrayToComplexArray(zeros(sr * 5));
    final y = arrayComplexConcat(x1, x2);
    expect(y.length, 10);
    expect(
        y,
        ArrayComplex([
          Complex(real: 1),
          Complex(real: 1),
          Complex(real: 1),
          Complex(real: 1),
          Complex(real: 1),
          Complex(real: 0),
          Complex(real: 0),
          Complex(real: 0),
          Complex(real: 0),
          Complex(real: 0)
        ]));
  });
}
