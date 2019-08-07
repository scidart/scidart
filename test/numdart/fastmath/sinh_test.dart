import 'dart:math';

import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('sinh', () {
    var a = sinh(pi / 2);

    var aExpec = 2.3012989023072947;

    print(a);

    expect(a, aExpec);
  });
}
