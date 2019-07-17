import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a 3x3 matrix', () {
    var matrix = Array2d.empty();
    var line = Array([1.0 ,2.0 , 3.0]);

    matrix.add(line);
    matrix.add(line);
    matrix.add(line);
    
    int i = 0;
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
    var line = Array([1.0 ,2.0 , 3.0]);

    matrix.add(line);
    matrix.add(line);
    matrix.add(line);

    var str = matrix.toString();

    var strExpec = 'Array2d([\n' +
        '  Array([1.0, 2.0, 3.0]), \n' +
        '  Array([1.0, 2.0, 3.0]), \n' +
        '  Array([1.0, 2.0, 3.0])\n' +
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

  test('multiply matrix', () {
    var a = Array2d([
      Array([4, 2, 1]),
      Array([16, 4, 1]),
      Array([64, 8, 1])
    ]);

    var b = Array2d([
      Array([1]),
      Array([1]),
      Array([1])
    ]);

    var c = a.dot(b);

    var cExpec = Array2d([
      Array([7]),
      Array([21]),
      Array([73])
    ]);

    expect(c, cExpec);
  });

  test('multiply column', () {
    var a = Array2d([
      Array([4, 2, 1]),
      Array([16, 4, 1]),
      Array([64, 8, 1])
    ]);

    var b = Array([2, 2, 2]);

    var c = a.multiplyColumns(b);

    var cExp = Array2d([
      Array([8.0, 4.0, 2.0]),
      Array([32.0, 8.0, 2.0]),
      Array([128.0, 16.0, 2.0])
    ]);

    expect(c, cExp);
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

  test('sumColumns', () {
    var a = Array2d([
      Array([1, 1, 1]),
      Array([1, 1, 1]),
      Array([1, 1, 1])
    ]);

    var b = a.sumColumns();

    print(b);

    var bExpec = Array([3, 3, 3]);

    expect(b, bExpec);
  });

  test('divideColumns', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var b = Array([2, 2, 2]);

    var c = a.divideColumns(b);

    print(c);

    var cExpec = Array2d([
      Array([1, 1, 1]),
      Array([1, 1, 1]),
      Array([1, 1, 1])
    ]);

    expect(c, cExpec);
  });

  test('subMatrix', () {
    var a = Array2d([
      Array([2, 2, 2]),
      Array([2, 2, 2]),
      Array([2, 2, 2])
    ]);

    var b = a.subMatrix(0, 1, 0, 1);

    print(b);

    var bExpec = Array2d([
      Array([2, 2]),
      Array([2, 2])
    ]);

    expect(b, bExpec);
  });

  test('truncateEachElement', () {
    var a = Array2d([
      Array([2.123456789, 2.123456789, 2.123456789]),
      Array([2.123456789, 2.123456789, 2.123456789]),
      Array([2.123456789, 2.123456789, 2.123456789])
    ]);

    a.truncateEachElement(4);

    print(a);

    var aExpec = Array2d([
      Array([2.1235, 2.1235, 2.1235]),
      Array([2.1235, 2.1235, 2.1235]),
      Array([2.1235, 2.1235, 2.1235])
    ]);

    expect(a, aExpec);
  });
}