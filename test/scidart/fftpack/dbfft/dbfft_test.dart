import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('dbfft basic', () {
    var N = 10.0;
    var fs = 128.0;
    var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);

    var f1 = 1; // 1Hz
    var sg1 = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

    var db = dbfft(sg1, fs);
    print(db);
  });
}
