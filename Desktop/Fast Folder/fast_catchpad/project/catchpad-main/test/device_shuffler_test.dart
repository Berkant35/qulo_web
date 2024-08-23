import 'package:catchpad/models/device/device_shuffler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Device Shuffler:',
    () {
      test(
        'shuffleUniquely method test',
        () {
          final ls1 = [1, 2, 3, 4, 5];

          cb() => DeviceShuffler.shuffleUniquely(
                ls1,
                (p0, p1) => p0 == p1,
              );

          // as this method works on random,
          // it is a healthy thing to repeat
          // for 10 times, with that being said,
          // we sometimes will not have an accurate result,
          // but we cannot do anything about that.
          for (var i = 0; i < 10; i++) {
            final newLs = cb();

            // this method will shuffle the list
            // without any element being in its
            // original position
            expect(newLs[0], isNot(ls1[0]));
            expect(newLs[1], isNot(ls1[1]));
            expect(newLs[2], isNot(ls1[2]));
            expect(newLs[3], isNot(ls1[3]));
            expect(newLs[4], isNot(ls1[4]));
          }
        },
      );
    },
  );
}
