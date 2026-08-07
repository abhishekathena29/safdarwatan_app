// Basic smoke test for the Safar Dar Watan app.

import 'package:flutter_test/flutter_test.dart';

import 'package:safdarwatan_app/main.dart';

void main() {
  testWidgets('Home renders brand and navigates to Collections',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SafarDarWatanApp());

    // The brand wordmark is in the app bar.
    expect(find.text('SAFAR DAR WATAN'), findsWidgets);

    // Bottom nav exposes the primary destinations.
    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('EXPLORE'), findsOneWidget);

    // Tapping "Explore" switches to the Collections screen.
    await tester.tap(find.text('EXPLORE'));
    await tester.pumpAndSettle();
    expect(find.text('Browse Collections'), findsOneWidget);
  });
}
