import 'dart:convert';
import 'dart:io';

import 'package:scidart/src/io/path/retrieve_file_path.dart';
import 'package:scidart/src/numdart/numdart.dart';

///  Write a list of line in a TXT file
///  [lines] : a list where each line is a string that will be written in the file
///  [fileName] : file name or path of the file
///  [baseDir] : optional, base directory to the file, if not informed, get current script path.
///  [delimiter] : optional, string used to separate values, by default is ";"
///  [encoding] : optional, the encoding of the file, default is utf8
///  [mode] : optional, the mode how the program will write the file:
///    * [FileMode.write]: truncates the file to length zero, default.
///    * [FileMode.append]: sets the initial write position to the end of the file.
///  References
///  ----------
///  .. [1] "Dart file class". https://api.dartlang.org/stable/2.4.0/dart-io/File-class.html. Retrieved 2019-07-26.
///  Examples
///  --------
///  >>> var fileName = 'data_array.csv';
///  >>> var data = Array2d([
///  >>>   Array([1, 2, 3, 4, 5]),
///  >>>   Array([2, 3, 4, 5, 6]),
///  >>>   Array([3, 4, 5, 6, 7]),
///  >>>   Array([4, 5, 6, 7, 8]),
///  >>>   Array([5, 6, 7, 8, 9]),
///  >>> ]);
///  >>> await writeLinesCSV(data, fileName);
void writeLinesCSV(Array2d data, String fileName,
    {String baseDir,
    String delimiter = ";",
    Encoding encoding = utf8,
    FileMode mode = FileMode.write}) async {
  var file =
      await File(retrieveFilePath(fileName, baseDir)).create(recursive: true);
  var sink = file.openWrite(encoding: encoding, mode: mode);

  for (var d in data) {
    sink.write(d.join(delimiter) + '\n');
  }

  await sink.close();
}
