import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/random/random_array.dart';

/// Generates an Array with n elements containing non-negative random floating
/// point value uniformly distributed in the range from 0.0, inclusive,
/// to 1.0, exclusive.
/// - [rows] : number of rows
/// - [columns] : number of columns
///
/// # Examples
/// ```dart
/// var x = randomArray2d(20, 20);
/// ```
Array2d randomArray2d(int rows, int columns) {
  var l = List.generate(columns, (_) => randomArray(rows));
  return Array2d(l);
}
