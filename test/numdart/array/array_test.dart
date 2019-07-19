import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  //#region constructors
  test('fromList', () {
    var list = Array([2.0, 2.0 , 2.0]);
    print(list);

    expect(list.length, 3);
  });
  //#endregion

  //#region operators tests
  test('set get length', () {
    var list = Array([2.0, 2.0 , 2.0]);
    print(list);

    expect(list.length, 3);

    list.length = 4;
    print(list);

    expect(list.length, 4);

    list.length = 2;
    print(list);

    expect(list.length, 2);

  });

  test('index operator', () {
    var list = Array([2.0, 2.0 , 2.0]);

    expect(list[0], 2.0);

    list[0] = 10.0;

    expect(list[0], 10.0);

  });

  test('create and mutiply arrays', () {
    var list = Array([2.0, 2.0 , 2.0]);
    var list2 = Array([2.0, 2.0 , 2.0]);

    var cList = list * list2;

    expect(cList.elementAt(0), 4.0);
    expect(cList.elementAt(1), 4.0);
    expect(cList.elementAt(2), 4.0);
  });
  //#endregion

  //#region array operations tests
  test('multiplyArrayToScalar', () {
    var list = Array([4.0, 4.0 , 4.0]);

    var cList = list.multiplyToScalar(2);

    expect(cList.elementAt(0), 8.0);
    expect(cList.elementAt(1), 8.0);
    expect(cList.elementAt(2), 8.0);
  });
  
  test('divideListToScalar', () {
    var list = Array([4.0, 8.0 , 16.0]);

    var cList = list.divisionToScalar(2);

    expect(cList.elementAt(0), 2.0);
    expect(cList.elementAt(1), 4.0);
    expect(cList.elementAt(2), 8.0);
  });

  test('toComplexList', () {
    var list = Array([1.0, 2.0 , 3.0]);

    var cList = list.toComplexArray();

    expect(cList.elementAt(0).real, 1.0);
    expect(cList.elementAt(0).imaginary, 0.0);

    expect(cList.elementAt(1).real, 2.0);
    expect(cList.elementAt(1).imaginary, 0.0);

    expect(cList.elementAt(2).real, 3.0);
    expect(cList.elementAt(2).imaginary, 0.0);
  });
  
  test('cosArray', () {
    var n = Array([0.5*pi, pi, (3/2)*pi, 2*pi]);

    var cosn = n.cos();

    print(n);

    print(cosn);

    var cosnExp = [0.0, -1.0, 0.0, 1.0];

    for(var i=0; i< n.length; i++) {
      expect(truncate(cosn[i], 4), truncate(cosnExp[i], 4));
    }
  });

  test('sum', () {
    var n = Array([1, 2, 3]);
    var n2 = Array([1, 2, 3]);
    var n3 = n + n2;

    var n3Exp = Array([2, 4, 6]);

    for(var i=0; i< n.length; i++) {
      expect(truncate(n3[i], 4), truncate(n3Exp[i], 4));
    }
  });

  test('compare ==', () {
    var n = Array([1, 2, 3]);
    var n2 = Array([1, 2, 3]);
    var n3 = n == n2;

    var n3Exp = true;

    expect(n3, n3Exp);
  });

  test('truncateLast', () {
    var n = Array([1, 2, 3]);
    var n2 = n.truncateLast();

    var n2Exp = Array([1, 2]);

    expect(n2.length, isNot(n.length));

    for(var i=0; i< n2.length; i++) {
      expect(truncate(n2[i], 4), truncate(n2Exp[i], 4));
    }
  });

  test('sqrt', () {
    var n = Array([4, 4, 4]);
    var nsqrt = n.sqrt();

    print(nsqrt);

    var nsqrtExp = Array([2, 2, 2]);

    expect(nsqrt, nsqrtExp);
  });

  test('truncateEachElement', () {
    var n = Array([4.123456789, 4.123456789, 4.123456789]);
    n.truncateEachElement(4);

    print(n);

    var nExp = Array([4.1235, 4.1235, 4.1235]);

    expect(n, nExp);
  });

  test('toColumnMatrix', () {
    var a = Array([4.0, 4.0, 4.0]);
    var n = a.toColumnMatrix();

    print(n);

    var nExp = Array2d([
      Array([4.0]),
      Array([4.0]),
      Array([4.0])
    ]);

    expect(n, nExp);
  });

  test('sum', () {
    var a = Array([1.0, 2.0, 3.0]);
    var n = a.sum();

    print(n);

    var nExp = 6.0;

    expect(n, nExp);
  });
  //#endregion

  //#region methods overload
  test('toString', () {
    var n = Array([1, 2, 3]);

    var str = n.toString();

    var strExpect = '\n' + '  Array([1.0, 2.0, 3.0])';

    print(str);

    expect(str, strExpect);
  });
  //#endregion
}