import 'package:scidart/src/numdart/numdart.dart';
import 'package:scidart/src/scidart/scidart.dart';
import 'package:test/test.dart';

void main() {
  test('get a kaiser window', () {
    var w = getWindow(['kaiser', 4.0], 9);

    var wExpec = Array([
      0.08848053,
      0.29425961,
      0.56437221,
      0.82160913,
      0.97885093,
      0.97885093,
      0.82160913,
      0.56437221,
      0.29425961
    ]);

    expect(arrayTruncateEachElement(w, 5, returnNewArray: true),
        arrayTruncateEachElement(wExpec, 5, returnNewArray: true));
  });

  test('get a kaiser window implicit', () {
    var w = getWindow(4.0, 9);

    var wExpec = Array([
      0.08848053,
      0.29425961,
      0.56437221,
      0.82160913,
      0.97885093,
      0.97885093,
      0.82160913,
      0.56437221,
      0.29425961
    ]);

    expect(arrayTruncateEachElement(w, 5, returnNewArray: true),
        arrayTruncateEachElement(wExpec, 5, returnNewArray: true));
  });

  test('get a blackman window', () {
    var w = getWindow('black', 10);

    var wExpec = Array([
      -1.38777878e-17,
      4.02128624e-02,
      2.00770143e-01,
      5.09787138e-01,
      8.49229857e-01,
      1.00000000e+00,
      8.49229857e-01,
      5.09787138e-01,
      2.00770143e-01,
      4.02128624e-02
    ]);

    expect(arrayTruncateEachElement(w, 5, returnNewArray: true),
        arrayTruncateEachElement(wExpec, 5, returnNewArray: true));
  });
}
