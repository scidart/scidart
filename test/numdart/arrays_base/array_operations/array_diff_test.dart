import 'package:scidart/numdart/arrays_base/array.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('diff simple', () {
    var a = Array([1, 2, 4, 7, 0]);
    var b = arrayDiff(a);

    var bExpec = Array([1, 2, 3, -7]);

    print(b);

    expect(b, bExpec);
  });
}
