import '../../../numdart.dart';

void checkParamsGetRangeArray(Array? y, Array? x, int dx) {
  if (x != null && x.length != y?.length) {
    throw FormatException('both array need have the same length');
  }
  if (dx <= 0) {
    throw FormatException('dx need be greater then 0');
  }
}
