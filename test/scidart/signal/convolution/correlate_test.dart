import 'package:scidart/scidart.dart';
import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('test cross-correlation case 1', () {
    var x = Array([1, 0, 0, 0, 0]);
    var y = Array([0, 0, 0, 0, 1]);
    var z = correlate(x, y);

    var zExpec = Array([1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]);

    expect(z, zExpec);
  });

  test('test cross-correlation case 2', () {
    var x = Array([0, 0, 1, 0, 0]);
    var y = Array([0, 0, 1, 0, 0]);
    var z = correlate(x, y);

    var zExpec = Array([0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0]);

    expect(z, zExpec);
  });

  test('test cross-correlation case 3', () {
    var x = Array([0, 0, 0, 0, 1]);
    var y = Array([1, 0, 0, 0, 0]);
    var z = correlate(x, y);

    var zExpec = Array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]);

    expect(z, zExpec);
  });
}
