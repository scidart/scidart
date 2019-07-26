import 'package:scidart/numdart/random/random_array2d.dart';
import 'package:test/test.dart';

void main() {
  test('random array2d', () {
    var x = randomArray2d(20, 20);
    print(x);
    var xExpec = 20;

    expect(x.row, xExpec);
    expect(x.column, xExpec);
  });
}
