///  Rotate to left the bits of a int number n times
///  [n]: number
///  [bits] : number of rotations
///  Examples
///  --------
///  >>> bitReverse(1, 3);
///  >>> 4
int bitReverse(int n, int bits) {
  int reversedN = n;
  int count = bits - 1;

  n >>= 1;
  while (n > 0) {
      reversedN = (reversedN << 1) | (n & 1);
      count--;
      n >>= 1;
  }

  return ((reversedN << count) & ((1 << bits) - 1));
}