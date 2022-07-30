// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption/data/petData.dart';
import 'package:pet_adoption/presentation/ui/petView.dart';

void main() {
  testWidgets('Test pet view', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: PetView(pet: PetData.petList[1], color: Colors.blue, index: 1)));

    // Verify correct name is recieved
    expect(find.text('Frankie'), findsOneWidget);
    expect(find.text('Kratos'), findsNothing);
  });
}
