import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('array operations', () {
    var a = Array([1.0, 2.0, 3.0]);
    var b = Array([1.0, 2.0, 3.0]);
    var aComplex = ArrayComplex([
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0),
      Complex(real: 2.0, imaginary: 2.0)
    ]);

    print(a + b);
    print(a - b);
    print(a * b);
    print(a / b);
    print(arrayConcat([a, b])); // array concatenation
    print(arrayMax(a));
    print(arrayMin(a));
    print(arrayDivisionToScalar(a, 2));
    print(a.getRangeArray(0, 2));
    print(arraySum(a));
    print(arrayToComplexArray(a));
    print(arrayPadStart(a, 2)); // add zeros at start of array
    print(arraySin(a)); // compute sin for all elements of array

    var c = Array([1.12121212, 2.12121212, 3.12121212]);
    print(arrayTruncateEachElement(c, 4,
        returnNewArray: true)); // truncate all values

    print(a == c);
    print(arrayPow(a, 2));
    print(arrayReshapeToMatrix(Array([1.0, 2.0, 3.0, 4.0]), 2));

    // Complex array operations
    print(arrayComplexAbs(aComplex));
    print(arrayComplexConjugate(aComplex));
    print(arrayComplexSum(aComplex, aComplex));
    print(arrayComplexPadStart(aComplex, 2));
  });
}
