import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('median', () {
    var a = Array([1.0, 2.0, 3.0]);
    var n = median(a);

    print(n);

    var nExp = 2.0;

    expect(n, nExp);
  });

  test('median unsorted', () {
    var a = Array([3.0, 1.0, 2.0]);
    var n = median(a);

    print(n);

    var nExp = 2.0;

    expect(n, nExp);
  });

  test('median does not modify the input', () {
    var a = Array([3.0, 1.0, 4.0, 2.0]);
    var n = median(a);

    expect(n, 2.5);
    expect(a, Array([3.0, 1.0, 4.0, 2.0]));
  });

  test('median of an empty array throws', () {
    expect(() => median(Array.empty()), throwsFormatException);
  });
}
