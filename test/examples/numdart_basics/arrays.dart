import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('arrays', () {
    // 1D array creation
    var a = Array([1.0, 2.0, 3.0]);

    print(a); // print vector

    // 2D array creation
    var mA = Array2d.empty();
    var line = Array([1.0, 2.0, 3.0]);

    mA.add(line);
    mA.add(line);
    mA.add(line);

    print(mA); // print matrix

    // 3D array creation
    var book = Array3d.empty();

    var page = Array2d.empty();
    page.add(Array([1.0, 2.0, 3.0]));
    page.add(Array([1.0, 2.0, 3.0]));
    page.add(Array([1.0, 2.0, 3.0]));

    book.add(page);
    book.add(page);
    book.add(page);

    print(book);

    // Create an array of complex numbers
    var aComplex = ArrayComplex([
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0)
    ]);

    print(aComplex);

    // indexing only columns
    var onlyOneColumn = mA.getColumn(1);
    print(onlyOneColumn);

    // subArray2d (submatrix)
    var subMatrix = mA.subArray2d(1, 2, 1, 1);
    print(subMatrix);
  });
}
