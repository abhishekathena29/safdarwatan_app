import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safdarwatan_app/main.dart';
import 'package:safdarwatan_app/widgets/bottom_nav_bar.dart';

void main() {
  testWidgets('bottom nav hugs its content and leaves room for the body',
      (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SafarDarWatanApp());
    await tester.pumpAndSettle();

    final nav =
        tester.renderObject(find.byType(HeirloomBottomNav)) as RenderBox;
    // Regression: a greedy Center once let the bar fill the whole screen.
    expect(nav.size.height, lessThan(120));
    expect(tester.takeException(), isNull); // no overflow
    expect(find.text('A JOURNEY HOME'), findsOneWidget); // body renders
  });

  testWidgets('navigates across destinations without layout errors',
      (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SafarDarWatanApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('ARCHIVE'));
    await tester.pumpAndSettle();
    expect(find.text('Browse Items'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('EXPLORE'));
    await tester.pumpAndSettle();
    expect(find.text('Browse Collections'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('CONTRIBUTE'));
    await tester.pumpAndSettle();
    expect(find.text('WHAT CAN YOU CONTRIBUTE?'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('MAP'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('NORTH AMERICA'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a collection card opens its items', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SafarDarWatanApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('EXPLORE'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('شاعری (shayari)'));
    await tester.pumpAndSettle();
    expect(find.text('COLLECTION'), findsOneWidget);
    expect(find.textContaining('still being gathered'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
