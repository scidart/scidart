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

    // Create a array of complex numbers
    var list = ArrayComplex([
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0)
    ]);

    print(list);

    // Array operations
    var b = Array([1.0, 2.0, 3.0]);
    print(a + b);
    print(a - b);
    print(a * b);
    print(a / b);
    print(arrayConcat(a, b));
    print(arrayMax(a));
    print(arrayMin(a));
    print(arrayDivisionToScalar(a, 2));
    print(a.getRangeArray(0, 2));

    var c = Array([1.12121212, 2.12121212, 3.12121212]);
    print(arrayTruncateEachElement(c, 4, returnNewArray: true));

    print(a == c);
    print(arrayPow(a, 2));
    print(arrayReshapeToMatrix(Array([1.0, 2.0, 3.0, 4.0]), 2));

    // Array 2D and Matrix operations
    var mB = Array2d([
      Array([1.0, 2.0, 3.0]),
      Array([4.0, 5.0, 6.0]),
      Array([7.0, 8.0, 10.0])
    ]);
    var mC = Array2d([
      Array([1]),
      Array([2]),
      Array([3])
    ]);

    print(matrixDeterminant(mA));
    print(matrixRank(mA));
    print(matrixTranspose(mA));
    print(matrixInverse(mC));
    print(matrixDot(mA, mC)); // Matrix product
    print(matrixQR(mA).Q()); // Matrix Q of QR decomposition
    print(matrixSolve(mB, mC)); // solve a linear system

    var mD = Array2d([
      Array([1.121212121212]),
      Array([2.121212121212]),
      Array([3.121212121212])
    ]);
    array2dTruncateEachElement(mD, 4);
    print(mD);

    print(mA + mB);
    print(mA - mB);
    print(mA * mB);
    print(mA / mB);
    print(mA == mB);

    print(matrixNormOne(mA));
    print(matrixNormTwo(mA));

    // Complex array operations
  });
}
