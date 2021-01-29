/// Compute the numerical derivative of a function in a certain point
/// - [x] : point in the function to calculate the derivative
/// - [f] : function to derivate
/// - [dx] : optional, interval between the points of the derivative, need be very small numbers, default is 0.00000001
///
/// # References
/// 1. "Create A Derivative Calculator in Python". https://medium.com/@jamesetaylor/create-a-derivative-calculator-in-python-72ee7bc734a4. Retrieved 2019-08-01.
/// 2. "Java 8 Derivative Approximation". https://gist.github.com/thekeenant/4bdab56307e5b8e909f308a037a668ce. Retrieved 2019-08-01.
/// 3. "scipy.misc.derivative". https://docs.scipy.org/doc/scipy-0.15.1/reference/generated/scipy.misc.derivative.html. Retrieved 2019-08-01.
///
/// # Examples
/// ```dart
/// var f = (x) => x * x * x;
///
/// print(differentiateFunction(2, f));
///
/// /* output:
/// 11.999999927070348
/// */
/// ```
double differentiateFunction(double x, Function f, {double dx = 0.00000001}) {
  return (f(x + dx) - f(x)) / dx;
}
