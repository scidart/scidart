import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('dbfft basic', () {
    var N = 10.0;
    var fs = 10.0;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);

    var f1 = 1; // 1Hz
    var sg1 = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

    print(sg1.length);

    var db0Exp = Array(
        [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2,
          1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5,
          2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8,
          3.9, 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5.0]);

    var db1Exp = Array(
        [-396.82385374, -401.33202052, -407.04917523, -415.43286071,
          -402.80353597, -399.06105916, -403.76851492, -402.76164868,
          -402.73285387, -402.06646097, -90.3089987, -396.29726491,
          -401.81175052, -405.28609821, -413.42907823, -397.75441859,
          -400.65583836, -403.14740317, -399.9349631, -401.81347237,
          -400.64236041, -397.59508689, -409.42546121, -410.31589832,
          -403.98704145, -398.3382704, -397.01763828, -415.52306087,
          -403.5856551, -401.83539856, -392.08781713, -402.99382545,
          -396.5412601, -405.43547178, -402.78279116, -398.2455716,
          -401.79845354, -406.38899573, -397.79290681, -397.6235298,
          -405.31839445, -402.71049484, -402.8673643, -407.16057593,
          -400.39101984, -399.69644255, -398.75944677, -400.92954176,
          -400.73214384, -395.77550257, -400.50268472]);

    var db = dbfft(sg1, fs);
    print(db[0].length);
    print(db[1].length);

    var frac = 2;
//    expect(arrayTruncateEachElement(db[0], frac, returnNewArray: true), arrayTruncateEachElement(db0Exp, frac, returnNewArray: true));
//    expect(arrayTruncateEachElement(db[1], frac, returnNewArray: true), arrayTruncateEachElement(db1Exp, frac, returnNewArray: true));
  });
}
