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

    var strExpec = "Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])])";

    print(matrix);

    expect(str, strExpec);
  });
}