import 'package:catchpad/models/game/game_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Num Range:',
    () {
      group(
        'Assertions:',
        () {
          test(
            'min cannot be bigger than max',
            () {
              try {
                NumRange(min: 4, max: 2);
                expect(false, true);
              } on AssertionError {
                expect(true, true);
              }
            },
          );
          test(
            'def must be between min and max',
            () {
              try {
                NumRange(min: 5, max: 10, def: 50);
                expect(false, true);
              } on AssertionError {
                expect(true, true);
              }

              try {
                NumRange(min: 5, max: 10, def: 1);
                expect(false, true);
              } on AssertionError {
                expect(true, true);
              }
            },
          );
          test(
            'step must be a divisor of def',
            () {
              const validRange = NumRange(
                min: 2,
                max: 100,
                step: 2,
              );
              try {
                validRange.copyWith(def: 3, step: 2);
                expect(false, true);
              } on AssertionError {
                expect(true, true);
              }

              try {
                validRange.copyWith(def: 12, step: 2);
                expect(true, true);
              } on AssertionError {
                expect(false, true);
              }
            },
          );
          test(
            'step must be a divisor of min',
            () {
              try {
                NumRange(
                  min: 2,
                  max: 99,
                  step: 3,
                );
                expect(false, true);
              } on AssertionError {
                expect(true, true);
              }

              try {
                const NumRange(
                  min: 6,
                  max: 99,
                  step: 3,
                );
                expect(true, true);
              } on AssertionError {
                expect(false, true);
              }
            },
          );
          test(
            'step must be a divisor of max',
            () {
              try {
                NumRange(
                  min: 6,
                  max: 100,
                  step: 3,
                );
                expect(false, true);
              } on AssertionError {
                expect(true, true);
              }

              try {
                const NumRange(
                  min: 6,
                  max: 99,
                  step: 3,
                );
                expect(true, true);
              } on AssertionError {
                expect(false, true);
              }
            },
          );
        },
      );
    },
  );
}
