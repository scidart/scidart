import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a one space 50 elem', () {
    var n = ones(3);
    var nExpect = [1.0, 1.0, 1.0];

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });
}