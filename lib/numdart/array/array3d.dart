import 'dart:collection';

import 'array2d.dart';

class Array3d extends ListBase<Array2d> {
  List<Array2d> l = List<Array2d>();
  
  Array3d();

  set length(int newLength) { l.length = newLength; }
  int get length => l.length;
  Array2d operator [](int index) => l[index];
  void operator []=(int index, Array2d value) { l[index] = value; } 
}