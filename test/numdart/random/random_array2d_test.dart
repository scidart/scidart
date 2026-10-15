import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('random array2d', () {
    var x = randomArray2d(20, 20);
    print(x);
    var xExpec = 20;

    expect(x.row, xExpec);
    expect(x.column, xExpec);
  });

  test('random array2d has rows x columns', () {
    var x = randomArray2d(2, 3);
    expect(x.row, 2);
    expect(x.column, 3);
    expect(x.every((r) => r.every((v) => v >= 0 && v < 1)), isTrue);
  });
}
