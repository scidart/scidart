import 'package:scidart/numdart/numdart.dart';
import 'package:scidart/numdart/time/timeit.dart';
import 'package:scidart/scidart/fftpack/fft/fft.dart';
import 'package:test/test.dart';

void main() {
  test('timeit', () {
    var duration = timeit(() {
      var a = Array2d([
        Array([1.0, 2.0, 3.0]),
        Array([4.0, 5.0, 6.0]),
        Array([7.0, 8.0, 10.0]),
      ]);

      var b = Array2d([
        Array([9.0]),
        Array([4.0]),
        Array([6.0])
      ]);
      var x = a.solve(b);

      print(x);

      var xx = x.columnToArray(0).toComplexArray();
      print(xx);
      var xf = fft(xx);
    });
    print('Array.solve() executed in ${duration}');
  });
}
