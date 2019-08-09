import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('statistic', () {
    var a = randomArray(100); // generate a random array
    print(a); // print array
    print(mean(a)); // mean of array
    print(median(a)); // median of array
    print(mode(a)); // mode of array
    print(standardDeviation(a)); // standard deviation of array
    print(variance(a)); // variance of array
  });
}
