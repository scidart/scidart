import '../numdart.dart';

///  Quadratic interpolation for estimating the true position of an
///  inter-sample maximum when nearby samples are known.
///  [y] : is a vector
///  [x] : is an index point for that vector.
///  Return
///  --------
///  [vx, vy], the coordinates of the vertex of a parabola that goes
///  through point x and its two neighbors.
///  References
///  ----------
///  .. [1] "A few simple frequency estimation methods in Python". https://gist.github.com/endolith/255291#L38. Retrieved 2019-08-07.
///  .. [2] "Quadratic Interpolation of Spectral Peaks". https://ccrma.stanford.edu/~jos/sasp/Quadratic_Interpolation_Spectral_Peaks.html. Retrieved 2019-08-07.
///  Examples
///  --------
///  Defining a vector f with a local maximum at index 3 (= 6), find local
///  maximum if points 2, 3, and 4 actually defined a parabola.
///  >>> var f = Array([2, 3, 1, 6, 4, 2, 3, 1]);
///  >>> parabolic(f, arrayMax(f));
///  [3.2142857142857144, 6.1607142857142856]
List parabolic(Array y, int x) {
  var xv =
      1 / 2.0 * (y[x - 1] - y[x + 1]) / (y[x - 1] - 2 * y[x] + y[x + 1]) + x;
  var yv = y[x] - 1 / 4.0 * (y[x - 1] - y[x + 1]) * (xv - x);
  return [xv, yv];
}
