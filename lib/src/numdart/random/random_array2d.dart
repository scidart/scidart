import 'package:scidart/src/numdart/arrays_base/array2d.dart';
import 'package:scidart/src/numdart/random/random_array.dart';

/// Generates an Array2d with [rows] rows and [columns] columns of random
/// floating point values uniformly distributed in the range from 0.0,
/// inclusive, to 1.0, exclusive.
/// - [rows] : number of rows
/// - [columns] : number of columns
///
/// # Examples
/// ```dart
/// var x = randomArray2d(2, 3);
/// print('${x.row} x ${x.column}');
///
/// /* output:
/// 2 x 3
/// */
/// ```
Array2d randomArray2d(int rows, int columns) {
  var l = List.generate(rows, (_) => randomArray(columns));
  return Array2d(l);
}
