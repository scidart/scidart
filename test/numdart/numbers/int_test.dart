import 'package:scidart/numdart/numdart.dart';
import 'package:test/test.dart';

void main() { 
  test('rotate 000001 3 times and get 00100', () {
    var n = bitReverse(1, 3);
    print(n);
    expect(n, 4);
  });

  test('highest one bit', () {
    var n = highestOneBit(130); // 0b10000010 => 1H: 2^8 = 128
    print(n);
    expect(n, 128);
  });
}