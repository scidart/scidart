import 'dart:convert';
import 'dart:io';

import 'package:scidart/io/path/retrieve_file_path.dart';

///  Read a TXT file and return a List where each element is line of the file
///  [fileName] : file name or path of the file
///  [baseDir] : optional, base directory to the file, if not informed, get current script path.
///  [encoding] : optional, the encoding of the file, default is utf8
Future<List> readLinesTxt(String fileName,
    {String baseDir, Encoding encoding = utf8}) async {
  return await File(retrieveFilePath(fileName, baseDir))
      .readAsLines(encoding: encoding);
}
