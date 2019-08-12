import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('find peaks', () {
    var a = Array([0, 1, 2, 2, 1, 0, 0, 1, 0]);
    var p = findPeaks(a);

    var iExpec = Array([2.0, 3.0, 7.0]);
    var xExpec = Array([2.0, 2.0, 1.0]);

    print(p[0]); // index of the points
    print(p[1]); // value of the points

    expect(p[0], iExpec);
    expect(p[1], xExpec);
  });

  test('find peaks threashold', () {
    var a = Array([0, 1, 2, 3, 1, 0, 0, 3, 0]);
    var p = findPeaks(a, threshold: 2.0);

    var iExpec = Array([3.0, 7.0]);
    var xExpec = Array([3.0, 3.0]);

    print(p[0]); // index of the points
    print(p[1]); // value of the points

    expect(p[0], iExpec);
    expect(p[1], xExpec);
  });

  test('find peaks threashold but none is greater than threashold', () {
    var a = Array([0, 1, 2, 3, 1, 0, 0, 3, 0]);
    var p = findPeaks(a, threshold: 20.0);

    var iExpec = Array([]);
    var xExpec = Array([]);

    print(p[0]); // index of the points
    print(p[1]); // value of the points

    expect(p[0], iExpec);
    expect(p[1], xExpec);
  });
}
