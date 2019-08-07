import 'package:scidart/scidart_io.dart';
import 'package:test/test.dart';

void main() {
  test('read txt', () async {
    var data = await readLinesTxt('stock_data.txt');
    print(data.length);

    expect(data.length, 15);
  });
}
