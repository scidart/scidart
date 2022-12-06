import 'package:scidart/numdart.dart';
import 'package:test/test.dart';

void main() {
  group('logspace', () {
    test(
      'should return four numbers spaced in log scale (six decimal places precision)',
      () {
        final expectedRes = Array([100, 215.443469, 464.15888336, 1000]);

        final res = logSpace(2, 3, num: 4);
        print(res);

        for (var i = 0; i < res.length; i++) {
          expect((res[i] - expectedRes[i]).abs(), lessThanOrEqualTo(0.000001));
        }
      },
    );

    test(
      'should return four numbers spaced in log scale but from bigger to smaller (six decimal places precision)',
      () {
        final expectedRes = Array([1000, 464.15888336, 215.443469, 100]);

        final res = logSpace(3, 2, num: 4);
        print(res);

        for (var i = 0; i < res.length; i++) {
          expect((res[i] - expectedRes[i]).abs(), lessThanOrEqualTo(0.000001));
        }
      },
    );

    test(
      'should return three numbers spaced in log scale (six decimal places precision)',
      () {
        final expectedRes = Array([100, 215.443469, 464.15888336]);

        final res = logSpace(2, 3, num: 4, endpoint: false);
        print(res);

        for (var i = 0; i < res.length; i++) {
          expect((res[i] - expectedRes[i]).abs(), lessThanOrEqualTo(0.000001));
        }
      },
    );
  });
}
