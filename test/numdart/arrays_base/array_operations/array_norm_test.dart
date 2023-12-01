import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arrayNorm', () {
    expect(arrayNorm(Array.fixed(3)), 0);
    expect(arrayNorm(Array([1, 0, 0])), 1);
    expect(arrayNorm(Array([0, -1, 0])), 1);
    expect(arrayNorm(Array([3, 4])), 5);
    expect(arrayNorm(Array([1.0, -3.0, 2.0])), closeTo(3.74165, 1e-5));
  });
}
