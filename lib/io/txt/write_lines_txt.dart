import 'dart:convert';
import 'dart:io';

import 'package:scidart/io/path/retrieve_file_path.dart';

///  Write a list of line in a TXT file
///  [lines] : a list where each line is a string that will be written in the file
///  [fileName] : file name or path of the file
///  [baseDir] : optional, base directory to the file, if not informed, get current script path.
///  [encoding] : optional, the encoding of the file, default is utf8
///  [mode] : optional, the mode how the program will write the file:
///    * [FileMode.write]: truncates the file to length zero, default.
///    * [FileMode.append]: sets the initial write position to the end of the file.
void writeLinesTxt(List<String> lines, String fileName,
    {String baseDir,
    Encoding encoding = utf8,
    FileMode mode = FileMode.write}) async {
  var file =
      await File(retrieveFilePath(fileName, baseDir)).create(recursive: true);
  var sink = file.openWrite(encoding: encoding, mode: mode);

  for (var l in lines) {
    sink.write(l + '\n');
  }

  await sink.close();
}
