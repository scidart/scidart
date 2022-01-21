import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('time', () {
    // the random function to measure the computation time
    var func = () {
      var x = createArrayRange(stop: 99);
      var y = randomArray(99);
      var py = PolyFit(x, y, 10);
      print(py);
      print(py.predict(55.5));
    };
    // the time measure the computation time if func and return
    var dur = timeit(func);
    print(dur); // print the computation time
  });
}
