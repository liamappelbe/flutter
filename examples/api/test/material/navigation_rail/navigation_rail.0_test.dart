// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_api_samples/material/navigation_rail/navigation_rail.0.dart' as example;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NavigationRail updates destination on tap', (WidgetTester tester) async {
    await tester.pumpWidget(const example.NavigationRailExampleApp());
    final NavigationRail navigationRailWidget = tester.firstWidget(find.byType(NavigationRail));

    /// NavigationRailDestinations must be rendered
    expect(find.text('First'), findsOneWidget);
    expect(find.text('Second'), findsOneWidget);
    expect(find.text('Third'), findsOneWidget);

    /// initial index must be zero
    expect(navigationRailWidget.selectedIndex, 0);

    /// switch to second tab
    await tester.tap(find.text('Second'));
    await tester.pumpAndSettle();
    expect(find.text('selectedIndex: 1'), findsOneWidget);

    /// switch to third tab
    await tester.tap(find.text('Third'));
    await tester.pumpAndSettle();
    expect(find.text('selectedIndex: 2'), findsOneWidget);
  });

  testWidgets('NavigationRail updates label type', (WidgetTester tester) async {
    await tester.pumpWidget(const example.NavigationRailExampleApp());

    // initial label type set to all.
    expect(find.text('Label type: all'), findsOneWidget);

    // switch to selected label type
    await tester.tap(find.text('Selected'));
    await tester.pumpAndSettle();
    expect(find.text('Label type: selected'), findsOneWidget);

    // switch to none label type
    await tester.tap(find.text('None'));
    await tester.pumpAndSettle();
    expect(find.text('Label type: none'), findsOneWidget);
  });

  testWidgets('Navigation rail updates group alignment', (WidgetTester tester) async {
    await tester.pumpWidget(const example.NavigationRailExampleApp());

    // initial group alignment set top top.
    expect(find.text('Group alignment: -1.0'), findsOneWidget);

    // switch to center alignment
    await tester.tap(find.text('Center'));
    await tester.pumpAndSettle();
    expect(find.text('Group alignment: 0.0'), findsOneWidget);

    // switch to bottom alignment
    await tester.tap(find.text('Bottom'));
    await tester.pumpAndSettle();
    expect(find.text('Group alignment: 1.0'), findsOneWidget);
  });

  testWidgets('NavigationRail shows leading/trailing widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const example.NavigationRailExampleApp());

    // Initially leading/trailing widgets are hidden.
    expect(find.byType(FloatingActionButton), findsNothing);
    expect(find.byType(IconButton), findsNothing);

    // Tap to show leading Widget.
    await tester.tap(find.text('Show Leading'));
    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(IconButton), findsNothing);

    // Tap to show trailing Widget.
    await tester.tap(find.text('Show Trailing'));
    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('Destinations have badge', (WidgetTester tester) async {
    await tester.pumpWidget(const example.NavigationRailExampleApp());

    // Test badge without label.
    final Badge notificationBadge = tester.firstWidget(
      find.ancestor(of: find.byIcon(Icons.bookmark_border), matching: find.byType(Badge)),
    );
    expect(notificationBadge.label, null);

    // Test badge with label.
    final Badge messagesBadge = tester.firstWidget(
      find.ancestor(of: find.byIcon(Icons.star_border), matching: find.byType(Badge)),
    );
    expect(messagesBadge.label, isNotNull);
  });
}
