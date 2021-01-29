/// Check the parameter before start compute the integral and return the range
/// - [a] : start inteval
/// - [b] : stop interval
/// - [n] : number of points between inteval
/// return the range of the integration
double checkParamsGetRange(double a, double b, int n) {
  if (n <= 0) {
    throw FormatException('Invalid value of n');
  }
  var range = b - a;
  if (range <= 0) {
    throw FormatException('Invalid range');
  }
  return range;
}
