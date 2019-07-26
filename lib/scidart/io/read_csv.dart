import 'dart:convert';
import 'dart:core';
import 'dart:io';

Future<List> readCSV(String path,
    {delimiter = ",", skipHeader = 0, skipFooter = 0}) async {
  final File file = File(path);

  List data = List();

  Stream<List> inputStream = file.openRead();
  await inputStream
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()) // Convert stream to individual lines.
      .listen((String line) {
    // Process results.
    List rows = line.split(delimiter); // split by comma
    List rows2 = List();
    for (var row in rows) {
      var aux = num.tryParse(row);
      if (aux == null) {
        rows2.add(row);
      } else {
        rows2.add(aux);
      }
    }
    data.add(rows2);
  }, onDone: () {
    print('File is now closed.');
  }, onError: (e) {
    print(e.toString());
  });

  return data;
}
