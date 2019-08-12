import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('parabolic interpolation', () {
    var f = Array([2, 3, 1, 6, 4, 2, 3, 1]);
    var p = parabolic(f, arrayArgMax(f));
    var pExpec = [3.2142857142857144, 6.1607142857142856];

    expect(p, pExpec);
  });
}
