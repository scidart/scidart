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

///  Reurn the highest one bit of a int
///  [n] : input number
///  References
///  ----------
///  .. [1] "understanding logic behind integer highestonebit method implementation". https://stackoverflow.com/questions/53369498/understanding-logic-behind-integer-highestonebit-method-implementation. Retrieved 2019-07-24.
///  Examples
///  --------
///  >>>
int highestOneBit(int n) {
  // HD, Figure 3-1
  n |= (n >> 1);
  n |= (n >> 2);
  n |= (n >> 4);
  n |= (n >> 8);
  n |= (n >> 16);
  return n - (n >> 1);
}