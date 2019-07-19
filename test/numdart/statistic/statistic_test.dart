import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('mean', () {
    var a = Array([1.0, 2.0, 3.0]);
    var n = mean(a);

    print(n);

    var nExp = 2.0;

    expect(n, nExp);
  });
}
