import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('simps array y', () {
    var y = Array([1, 2, 3]);
    var i = simpsArray(y);
    var iExpec = 4;
    expect(i, iExpec);
  });

  test('simps array y and x', () {
    var y = Array([1, 2, 3]);
    var x = Array([4, 6, 8]);
    var i = simpsArray(y, x: x);
    var iExpec = 8;
    expect(i, iExpec);
  });

  test('simps array y and dx', () {
    var y = Array([1, 2, 3]);
    var dx = 2;
    var i = simpsArray(y, dx: dx);
    var iExpec = 8;
    expect(i, iExpec);
  });

  test('simps array arrange 0 10', () {
    var x = arange(start: 0, stop: 10);
    var y = arange(start: 0, stop: 10);
    var i = simpsArray(y, x: x);
    var iExpec = 40.5;
    expect(i, iExpec);
  });
}
