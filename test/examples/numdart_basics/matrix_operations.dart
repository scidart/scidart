import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('matrix operations', () {
    var mA = Array2d.empty();
    var line = Array([1.0, 2.0, 3.0]);

    mA.add(line);
    mA.add(line);
    mA.add(line);

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

    print(matrixDeterminant(mA)); // find matrix determinant
    print(matrixRank(mA)); // matrix rank
    print(matrixTranspose(mA)); // matrix transposition
    print(matrixInverse(mC)); // matrix inverse
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
  });
}
