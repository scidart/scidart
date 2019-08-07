import 'package:scidart/scidart.dart';
import 'package:scidart/scidart_io.dart';
import 'package:test/test.dart';

void main() {
  test('write csv', () async {
    var data = Array2d([
      Array([1, 2, 3, 4, 5]),
      Array([2, 3, 4, 5, 6]),
      Array([3, 4, 5, 6, 7]),
      Array([4, 5, 6, 7, 8]),
      Array([5, 6, 7, 8, 9]),
    ]);

    var fileName = 'data_array.csv';

    await writeLinesCSV(data, fileName);
    var dataRead = await readCSV(fileName, convertToArray2d: true);

    expect(dataRead, data);
  });
}
