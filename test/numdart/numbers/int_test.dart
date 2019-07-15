import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() { 
  test('rotate 000001 3 times and get 00100', () {
    var n = bitReverse(1, 3);
    print(n);
    expect(n, 4);
  });
}