import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _makeTestableWidget({
  required List<WidgetBuilder> builders,
  required Locale locale,
}) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    locale: locale,
    home: Column(
      children: builders.map(
        (builder) {
          return Builder(builder: builder);
        },
      ).toList(),
    ),
  );
}

void main() {
  group(
    'Translations:',
    () {
      testWidgets(
        'Check if the translations works',
        (tester) async {
          await tester.pumpWidget(
            _makeTestableWidget(
              builders: [
                (context) => Text(L10n.inst(context).request_activate_location),
              ],
              locale: const Locale('en'),
            ),
          );
          await tester.pump();

          expect(find.text('Activate location'), findsOneWidget);

          await tester.pumpWidget(
            _makeTestableWidget(
              builders: [
                (context) => Text(L10n.inst(context).request_activate_location),
              ],
              locale: const Locale('tr'),
            ),
          );
          await tester.pump();

          expect(find.text('Konumu aktifleştir'), findsOneWidget);
        },
      );
    },
  );

  // TODO: my goal in this test file was to test generic translations
  // e.g. arrangement_index(1) => '1st', arrangement_index(2) => '2nd'
  // but I faced more than one problem:
  // 1. get the test to work on localization, after many searches and
  // going back and forth, but finally I found the solution here
  // https://github.com/flutter/flutter/issues/22193#issuecomment-738736904.
  // I'm not really sure what makes it different from other solutions and
  // why only this solution works. it's a black box.
  // 2. I was trying to implement the example above arrangement_index(1) => '1st',
  // but I did not know how, so I've written a stackoverflow question,
  // https://stackoverflow.com/q/72696680/12555423, I'll be implementing that
  // functionality when I get an answer, for now I'll stick with
  // L10n.inst(context).player + '1', L10n.inst(context).player + '2' as its format
  // works for the only 2 languages we're using rn ['en', 'tr'].
  // btw the string picked in this test is a random, just to verify l10n works.
}
