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

  test('QRDecomposition', () {
    var a = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]);

    var qr = a.QRDecomposition();

    expect(qr is QR, true);
  });

  test('subMatrixFromArray', () {
    var a = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0]),
      Array([64.0, 8.0, 1.0])
    ]);

    var subA = a.subMatrixFromArray(Array([0, 1]), 0, 2);

    var subAExp = Array2d([
      Array([4.0, 2.0, 1.0]),
      Array([16.0, 4.0, 1.0])
    ]);

    print(subA);

    expect(subA, subAExp);
  });

  test('solve', () {
    var a = Array2d([
      Array([3.0, 1.0]),
      Array([1.0, 2.0])
    ]);

    var b = Array2d([
      Array([9.0]),
      Array([8.0])
    ]);

    var x = a.solve(b);

    var xExp = Array2d([
      Array([2]),
      Array([3])
    ]);

    print(x);

    expect(x, xExp);
  });

  test('solve2', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var frac = 6;

    var b = Array2d([
      Array([9.0]),
      Array([4.0]),
      Array([6.0])
    ]);

    var x = a.solve(b);
    x.truncateEachElement(frac);

    var xExp = Array2d([
      Array([-5.33333333]),
      Array([-3.33333333]),
      Array([7.0])
    ]);
    xExp.truncateEachElement(frac);

    print(x);

    expect(x, xExp);
  });

  test('inverse', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var frac = 6;

    var i = a.inverse();
    i.truncateEachElement(frac);

    var iExp = Array2d([
      Array([-0.66666667, -1.33333333, 1.0]),
      Array([-0.66666667, 3.66666667, -2.0]),
      Array([1.0, -2.0, 1.0])
    ]);
    iExp.truncateEachElement(frac);

    print(i);

    expect(i, iExp);
  });

  test('transpose', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var t = a.transpose();

    var tExp = Array2d([
      Array([1.0, 4.0, 7.0]),
      Array([2.0, 5.0, 8.0]),
      Array([3.0, 6.0, 10.0])
    ]);

    print(t);

    expect(t, tExp);
  });

  test('columnToArray', () {
    var a = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0]),
    ]);

    var b = a.columnToArray(2);

    var bExp = Array([3.0, 6.0, 10.0]);

    print(b);

    expect(b, bExp);
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

  test('fromVector', () {
    var a = Array2d.fromVector(Array([1, 2, 3, 4]), 2);

    print(a);

    var aExpec = Array2d([
      Array([1, 3]),
      Array([2, 4])
    ]);

    expect(a, aExpec);
  });

  test('norm1', () {
    var a = Array2d([
      Array([1, 2, 3]),
      Array([1, 2, 3]),
      Array([1, 2, 3]),
    ]);

    var norm = a.norm1();
    print(norm);

    var normExpec = 9;

    expect(norm, normExpec);
  });

  test('norm2', () {
    var a = Array2d([
      Array([1, 2, 3]),
      Array([1, 2, 3]),
      Array([1, 2, 3]),
    ]);

    var norm = truncate(a.norm2(), 4);
    print(a.norm2());
    print(norm);

    var normExpec = 6.4807;

    expect(norm, normExpec);
  });
}