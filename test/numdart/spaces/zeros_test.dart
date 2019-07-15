import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('create a zero space 50 elem', () {
    var n = zeros(3);
    var nExpect = [0.0, 0.0, 0.0];

    var fractionDigits = 8;
    for (var i = 0; i < n.length; i++) {
      expect(
          truncate(n[i], fractionDigits), truncate(nExpect[i], fractionDigits));
    }

    expect(n.length, nExpect.length);
  });
}

