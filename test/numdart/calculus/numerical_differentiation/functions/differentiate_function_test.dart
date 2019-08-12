import 'package:scidart/src/numdart/numdart.dart';
import 'package:test/test.dart';

void main() {
  test('basic derivative', () {
    var f = (x) => x * x * x;
    var df = differentiateFunction(2, f);
    print(df);
    df = truncate(df, 6);

    var dfExpec = 12.0;

    expect(df, dfExpec);
  });
}
