import '../array.dart';

/// Concatenate a list of arrays and return
///
/// # Examples
/// ```dart
/// var list = Array([1,2,3]);
/// var b = Array([4]);
///
/// print(arrayConcat([a, b]));
///
/// /* expected output:
/// Array([1, 2, 3, 4])
/// */
/// ```
Array arrayConcat(List<Array> arrays) {
  //Array a, Array b
  var c = Array.empty();
  arrays.forEach((array) {
    array.forEach((e) {
      c.add(e);
    });
  });
  return c;
}
