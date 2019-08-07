import 'package:scidart/scidart.dart';
import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('convolve two complex signals', () {
    var xi = arrayToComplexArray(Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]));
    var yi = arrayToComplexArray(Array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]));
    var zi = convolutionComplex(xi, yi);
    print(zi);
    print(zi.length);

    var ziExpec = ArrayComplex([
      Complex(real: 1.0000000000000029, imaginary: -1.794120407794253e-14),
      Complex(real: 1.9999999999999993, imaginary: -1.403321903126198e-14),
      Complex(real: 2.9999999999999916, imaginary: -1.4921397450962105e-14),
      Complex(real: 3.9999999999999907, imaginary: -9.947598300641402e-15),
      Complex(real: 4.999999999999984, imaginary: -3.907985046680551e-15),
      Complex(real: 5.999999999999984, imaginary: 3.552713678800501e-15),
      Complex(real: 6.999999999999996, imaginary: 3.552713678800501e-16),
      Complex(real: 8.0, imaginary: -7.460698725481052e-15),
      Complex(real: 8.99999999999999, imaginary: 2.575717417130363e-15),
      Complex(real: 9.999999999999991, imaginary: 8.764043402932554e-15),
      Complex(real: 8.999999999999998, imaginary: 2.0161650127192842e-14),
      Complex(real: 7.999999999999986, imaginary: -1.1013412404281553e-14),
      Complex(real: 6.999999999999993, imaginary: 2.842170943040401e-15),
      Complex(real: 6.0000000000000036, imaginary: 7.105427357601002e-15),
      Complex(real: 4.999999999999984, imaginary: 3.907985046680551e-15),
      Complex(real: 3.9999999999999987, imaginary: 1.4210854715202005e-15),
      Complex(real: 3.0000000000000053, imaginary: -2.4868995751603505e-15),
      Complex(real: 1.9999999999999982, imaginary: 1.687538997430238e-14),
      Complex(real: 1.0000000000000082, imaginary: 8.704148513061228e-15)
    ]);

    expect(zi, ziExpec);
  });
}
