import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';
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
      var x = matrixSolve(a, b);

      print(x);

      var xx = arrayToComplexArray(matrixColumnToArray(x, 0));

      var xf = fft(xx);

      print(xf);
    });
    print('Array.solve() executed in $duration');
  });
}
