import 'package:scidart/numdart/arrays_base/array.dart';
import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('trapz array', () {
    var y = Array([1, 2, 3]);
    var i = trapzArray(y);
    var iExpec = 4;
    expect(i, iExpec);
  });

  test('trapz array y and x', () {
    var y = Array([1, 2, 3]);
    var x = Array([4, 6, 8]);
    var i = trapzArray(y, x: x);
    var iExpec = 8;
    expect(i, iExpec);
  });

  test('trapz array y and dx', () {
    var y = Array([1, 2, 3]);
    var dx = 2;
    var i = trapzArray(y, dx: dx);
    var iExpec = 8;
    expect(i, iExpec);
  });

  test('trapz array arrange 0 10', () {
    var x = arange(start: 0, stop: 10);
    var y = arange(start: 0, stop: 10);
    var i = trapzArray(y, x: x);
    var iExpec = 40.5;
    expect(i, iExpec);
  });
}
