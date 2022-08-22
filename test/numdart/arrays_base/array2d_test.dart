import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a 3x3 matrix', () {
    var matrix = Array2d.empty();
    var line = Array([1.0, 2.0, 3.0]);

    matrix.add(line);
    matrix.add(line);
    matrix.add(line);

    var i = 0;
    expect(matrix[i].elementAt(0), 1.0);
    expect(matrix[i].elementAt(1), 2.0);
    expect(matrix[i].elementAt(2), 3.0);

    i = 1;
    expect(matrix[i].elementAt(0), 1.0);
    expect(matrix[i].elementAt(1), 2.0);
    expect(matrix[i].elementAt(2), 3.0);

    i = 2;
    expect(matrix[i].elementAt(0), 1.0);
    expect(matrix[i].elementAt(1), 2.0);
    expect(matrix[i].elementAt(2), 3.0);
  });

  test('toString', () {
    var matrix = Array2d.empty();
    var line = Array([1.0, 2.0, 3.0]);

    matrix.add(line);
    matrix.add(line);
    matrix.add(line);

    var str = matrix.toString();

    var strExpec = 'Array2d([\n'
        '  Array([1.0, 2.0, 3.0]), \n'
        '  Array([1.0, 2.0, 3.0]), \n'
        '  Array([1.0, 2.0, 3.0])\n'
        '])';

    print(matrix);

    expect(str, strExpec);
  });

  test('multiply array', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var b = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var c = a * b;

    var cExpec = Array2d([
      Array([4, 4, 4]),
      Array([4, 4, 4]),
      Array([4, 4, 4])
    ]);

    expect(c, cExpec);
  });

  test('divide array', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);
    var b = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var c = a / b;

    var cExpec = Array2d([
      Array([1, 1, 1]),
      Array([1, 1, 1]),
      Array([1, 1, 1])
    ]);

    expect(c, cExpec);
  });

  test('==', () {
    var a = Array2d([
      Array([4, 2, 1]),
      Array([16, 4, 1]),
      Array([64, 8, 1])
    ]);

    var b = Array2d([
      Array([4, 2, 1]),
      Array([16, 4, 1]),
      Array([64, 8, 1])
    ]);

    var c = a == b;

    var cExp = true;

    expect(c, cExp);
  });

  test('-', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var b = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var c = a - b;

    var cExpec = Array2d([
      Array([0, 0, 0]),
      Array([0, 0, 0]),
      Array([0, 0, 0])
    ]);

    expect(c, cExpec);
  });

  test('+', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var b = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var c = a + b;

    var cExpec = Array2d([
      Array([4, 4, 4]),
      Array([4, 4, 4]),
      Array([4, 4, 4])
    ]);

    expect(c, cExpec);
  });

  test('fromVector', () {
    var a = Array2d.fromVector(Array([1, 2, 3, 4]), 2);

    print(a);

    var aExpec = Array2d([
      Array([1, 3]),
      Array([2, 4])
    ]);

    expect(a, aExpec);
  });

  test('get column', () {
    var matrix = Array2d.empty();
    var line = Array([1.0, 2.0, 3.0]);

    matrix.add(line);
    matrix.add(line);
    matrix.add(line);

    print(matrix.getColumn(1));
  });

  test('sub array2d', () {
    var matrix = Array2d.empty();
    var line = Array([1.0, 2.0, 3.0]);

    matrix.add(line);
    matrix.add(line);
    matrix.add(line);

    print(matrix.subArray2d(0, 1, 1, 2));
  });
}
