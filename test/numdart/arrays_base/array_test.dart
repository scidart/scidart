import 'package:scidart/src/numdart/numdart.dart';
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

  test('create and divide arrays', () {
    var list = Array([2.0, 2.0, 2.0]);
    var list2 = Array([2.0, 2.0, 2.0]);

    var cList = list / list2;

    expect(cList.elementAt(0), 1.0);
    expect(cList.elementAt(1), 1.0);
    expect(cList.elementAt(2), 1.0);
  });
  //#endregion

  //#region array operations tests
  test('sum', () {
    var n = Array([1, 2, 3]);
    var n2 = Array([1, 2, 3]);
    var n3 = n + n2;

    var n3Exp = Array([2, 4, 6]);

    for (var i = 0; i < n.length; i++) {
      expect(truncate(n3[i], 4), truncate(n3Exp[i], 4));
    }
  });

  test('subtract', () {
    var n = Array([1, 2, 3]);
    var n2 = Array([1, 2, 3]);
    var n3 = n - n2;

    var n3Exp = Array([0, 0, 0]);

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

  test('getRangeArray', () {
    var a = Array([1, 2, 3, 4, 5]);
    var b = a.getRangeArray(1, 3);

    var bExpec = Array([2, 3]);

    expect(b, bExpec);
  });

  test('getRangeArrayStep', () {
    var a = Array([1, 2, 3, 4, 5]);
    var b = a.getRangeArray(0, a.length, step: 2);

    var bExpec = Array([1, 3, 5]);

    expect(b, bExpec);
  });
  //#endregion

  //#region methods overload
  test('toString', () {
    var n = Array([1, 2, 3]);

    var str = n.toString();

    var strExpect = '\n' '  Array([1.0, 2.0, 3.0])';

    print(str);

    expect(str, strExpect);
  });
  //#endregion
}