import 'package:scidart/io.dart';
import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('write txt', () async {
    var data = Array2d([
      Array([1, 2, 3, 4, 5]),
      Array([2, 3, 4, 5, 6]),
      Array([3, 4, 5, 6, 7]),
      Array([4, 5, 6, 7, 8]),
      Array([5, 6, 7, 8, 9]),
    ]);

    var fileName = 'data_array.txt';

    await writeLinesTxt(data.toString().split('\n'), fileName);
    var dataRead = await readLinesTxt(fileName);

    print(dataRead);

    expect(dataRead, data.toString().split('\n'));
  });
}
