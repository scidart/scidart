import 'package:scidart/numdart/linalg/matrix_operations/matrix_column_to_array.dart';
import 'package:scidart/numdart/linalg/matrix_operations/matrix_solve.dart';
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
      var x = matrixSolve(a, b);

      print(x);

      var xx = arrayToComplexArray(matrixColumnToArray(x, 0));

      var xf = fft(xx);

      print(xf);
    });
    print('Array.solve() executed in ${duration}');
  });
}
