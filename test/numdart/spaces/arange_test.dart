import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create an arange with 3 elements', () {
    var n = arange(stop: 3);

    var nExpect = Array([0.0, 1, 2]);

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });

  test('create an arange with 4 elements', () {
    var n = arange(start: 3, stop: 7);

    var nExpect = Array([3.0, 4, 5, 6]);

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });

  test('create an arange with 2 elements', () {
    var n = arange(start: 3, stop: 7, step: 2);

    print(n);

    var nExpect = Array([3.0, 5]);

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });

  test('create an arange with 1 elements', () {
    var n = arange(start: 3, stop: 7, step: 3);

    print(n);

    var nExpect = Array([3.0]);

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });
}
