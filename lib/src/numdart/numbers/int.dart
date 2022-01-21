/// Rotate to left the bits of an int number n times
/// - [n] : number
/// - [bits] : number of rotations
///
/// # Examples
/// ```dart
/// print(bitReverse(1, 3));
///
/// /* output:
/// 4
/// */
/// ```
int bitReverse(int n, int bits) {
  var reversedN = n;
  var count = bits - 1;

  n >>= 1;
  while (n > 0) {
    reversedN = (reversedN << 1) | (n & 1);
    count--;
    n >>= 1;
  }

  return ((reversedN << count) & ((1 << bits) - 1));
}

///  Reurn the highest one bit of an int
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

///  Convert a bool to int, if true return 1, else 0
int boolToInt(bool a) => a ? 1 : 0;

///  Convert an int to bool, if 0 return false, else true
bool intToBool(int a) => a == 0 ? false : true;

/// Check if [a] is an Even number.
bool isEven(int a) => a % 2 == 0;

/// Check if [a] is an Odd number.
bool isOdd(int a) => a % 2 != 0;

/// CHeck if [n] is power of 2.
bool isPowerOf2(int n) => (n & (n - 1)) == 0;
