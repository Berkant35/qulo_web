import 'package:catchpad/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group(
    'Num Extensions:',
    () {
      group(
        'The Metric System:',
        () {
          test(
            'cm to mm',
            () {
              const cm10Dbl = 10.0;
              const cm10Int = 10;

              // there would be no rounding for ints
              // because this is a multiplication operation.

              expect(cm10Dbl.cmToMm, 100.0);
              expect(cm10Int.cmToMm, 100);
            },
          );

          test(
            'mm to cm',
            () {
              const mm100Dbl = 100.0;
              const mm100Int = 100;

              const mmIrregularDbl = 10.5;
              const mmIrregularInt = 11;

              expect(mm100Dbl.mmToCm, 10.0);
              expect(mm100Int.mmToCm, 10);

              expect(mmIrregularDbl.mmToCm, 1.05);
              expect(mmIrregularInt.mmToCm, 1);
            },
          );
        },
      );

      group(
        'The Time System:',
        () {
          test(
            's to ms',
            () {
              const s10Dbl = 10.0;
              const s10Int = 10;

              expect(s10Dbl.secToMs, 10000.0);
              expect(s10Int.secToMs, 10000);
            },
          );

          test(
            'ms to s',
            () {
              const ms1000Dbl = 1000.0;
              const ms1000Int = 1000;

              const msIrregularDbl = 1005.5;
              const msIrregularInt = 1006;

              expect(ms1000Dbl.msToSec, 1.0);
              expect(ms1000Int.msToSec, 1);

              expect(msIrregularDbl.msToSec, 1.0055);
              expect(msIrregularInt.msToSec, 1);
            },
          );
        },
      );
    },
  );
}
