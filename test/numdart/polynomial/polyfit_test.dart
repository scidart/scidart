import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/numdart/polynomial/polyfit.dart';
import 'package:test/test.dart';

void main() {
  test('polyfit simple', () {
    const int degree = 2;
    var x = Array([0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]);
    var y = Array(
        [1.0, 6.0, 17.0, 34.0, 57.0, 86.0, 121.0, 162.0, 209.0, 262.0, 321.0]);

    var p = polyfit(x, y, degree);

    print(p);

    var pExpect = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]);

    expect(p, pExpect);
  });
}
