import 'dart:collection';

class Array2d extends ListBase<List<double>> {
  List<List<double>> l = [];
  
  Array2d();

  set length(int newLength) { l.length = newLength; }
  int get length => l.length;
  List<double> operator [](int index) => l[index];
  void operator []=(int index, List<double> value) { l[index] = value; } 
}