import 'dart:collection';

import 'array2d.dart';

/// Class to create 3 dimensions Array.
///
/// # Constructors:
/// ```dart
/// Array3d(List<double> list) // default constructor
///
/// Array3d.empty() // empty array
///
/// Array3d.fromArray(Array list) // from another array
///
/// Array3d.fixed(int length) // from a fixed length
/// ```
///
/// # Examples
/// ```dart
/// import 'package:scidart/src/numdart/numdart.dart';
///
/// var book = Array3d.empty();
/// var page = Array2d.empty();
///
/// page.add(Array([1.0 ,2.0 , 3.0]));
/// page.add(Array([1.0 ,2.0 , 3.0]));
/// page.add(Array([1.0 ,2.0 , 3.0]));
/// book.add(page);
/// book.add(page);
/// book.add(page);
///
/// print(book);
///
/// /* output:
/// Array3d([Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])]), Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])]), Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])])])
/// */
/// ```
class Array3d extends ListBase<Array2d> {
  List<Array2d?> l = [];

  //#region constructors
  Array3d(List<Array2d> list) {
    l = list;
  }

  Array3d.empty();

  Array3d.fromArray(Array3d list) {
    l = list;
  }

  Array3d.fixed(int length) {
    l = List<Array2d>.filled(length, Array2d.empty());
  }
  //#endregion

  //#region operators
  @override
  set length(int newLength) {
    l.length = newLength;
  }

  /// Return the length of Array3d
  ///
  /// # Examples
  /// ```dart
  /// var book = Array3d.empty();
  /// var page = Array2d.empty();
  /// page.add(Array([1.0 ,2.0 , 3.0]));
  /// page.add(Array([1.0 ,2.0 , 3.0]));
  /// page.add(Array([1.0 ,2.0 , 3.0]));
  /// book.add(page);
  /// book.add(page);
  /// book.add(page);
  ///
  /// print(book.length);
  ///
  /// /* output:
  /// 3
  /// */
  /// ```
  @override
  int get length => l.length;
  @override
  Array2d operator [](int index) => l[index] ?? Array2d.empty();
  @override
  void operator []=(int index, Array2d value) {
    l[index] = value;
  }
  //#endregion

  //#region overload methods
  /// Convert an Array3d object to a String representation
  ///
  /// # Examples
  /// ```dart
  /// var book = Array3d.empty();
  /// var page = Array2d.empty();
  ///
  /// page.add(Array([1.0 ,2.0 , 3.0]));
  /// page.add(Array([1.0 ,2.0 , 3.0]));
  /// page.add(Array([1.0 ,2.0 , 3.0]));
  /// book.add(page);
  /// book.add(page);
  /// book.add(page);
  ///
  /// print(book);
  ///
  /// /* output:
  /// Array3d([Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])]), Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])]), Array2d([Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0]), Array([1.0, 2.0, 3.0])])])
  /// */
  /// ```
  @override
  String toString() {
    var str = IterableBase.iterableToFullString(this, '[', ']');
    return 'Array3d($str)';
  }
  //#endregion
}
