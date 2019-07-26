import 'package:scidart/io/io.dart';

main(List<String> arguments) async {
  var data = await readCSV('stock_data.csv', delimiter: ',');
  print(data);
}