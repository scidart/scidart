double checkParamsGetRange(double a, double b, int n) {
  if (n <= 0) {
    throw FormatException("Invalid value of n");
  }
  double range = b - a;
  if (range <= 0) {
    throw FormatException("Invalid range");
  }
  return range;
}
