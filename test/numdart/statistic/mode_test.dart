import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('mode', () {
    var a = Array([1.0, 2.0, 3.0, 3]);
    var n = mode(a);

    print(n);

    var nExp = 3.0;

    expect(n, nExp);
  });

  test('mode with more than one most frequent value, issue #62', () {
    var a = Array([5, 0, 6, 8, 10, 8, 10]);

    expect(mode(a), 8.0);
    expect(multimode(a), Array([8.0, 10.0]));
  });

  test('multimode when all values have the same frequency', () {
    var a = Array([1, 1, 2, 2, 3, 3]);

    expect(multimode(a), Array([1.0, 2.0, 3.0]));
  });

  test('mode of an empty array throws', () {
    expect(() => mode(Array.empty()), throwsFormatException);
    expect(multimode(Array.empty()), Array.empty());
  });
}
