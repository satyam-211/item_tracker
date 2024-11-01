import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:item_tracker/providers/item_provider.dart';
import 'package:item_tracker/screens/item_list_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider<ItemProvider>(
      create: (_) => ItemProvider(),
      child: const MaterialApp(
        home: ItemListScreen(),
      ),
    );
  }

  testWidgets('Displays empty message when no items are present',
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('No items added yet!'), findsOneWidget);
      });

  testWidgets('Adds a new item and displays it in the list',
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        // Tap the add button
        final addButton = find.byIcon(Icons.add);
        expect(addButton, findsOneWidget);
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        // Enter item name
        await tester.enterText(find.byType(TextFormField).at(0), 'Test Item');
        // Enter item description
        await tester.enterText(
            find.byType(TextFormField).at(1), 'Test Description');

        // Save the form
        final saveButton = find.byIcon(Icons.save);
        expect(saveButton, findsOneWidget);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        // Verify the item is displayed
        expect(find.text('Test Item'), findsOneWidget);
        expect(find.text('Test Description'), findsOneWidget);
      });

  testWidgets('Edits an existing item',
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        // Add an item first
        final addButton = find.byIcon(Icons.add);
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(0), 'Item 1');
        await tester.enterText(
            find.byType(TextFormField).at(1), 'Description 1');
        final saveButton = find.byIcon(Icons.save);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        // Tap on the item to edit
        await tester.tap(find.text('Item 1'));
        await tester.pumpAndSettle();

        // Change the name and description
        await tester.enterText(find.byType(TextFormField).at(0), 'Updated Item');
        await tester.enterText(
            find.byType(TextFormField).at(1), 'Updated Description');

        // Save the form
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        // Verify the updated item is displayed
        expect(find.text('Updated Item'), findsOneWidget);
        expect(find.text('Updated Description'), findsOneWidget);
        expect(find.text('Item 1'), findsNothing);
        expect(find.text('Description 1'), findsNothing);
      });

  testWidgets('Removes an item from the list',
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        // Add an item first
        final addButton = find.byIcon(Icons.add);
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(0), 'Item 1');
        await tester.enterText(
            find.byType(TextFormField).at(1), 'Description 1');
        final saveButton = find.byIcon(Icons.save);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        // Verify the item is displayed
        expect(find.text('Item 1'), findsOneWidget);

        // Tap the delete button
        final deleteButton = find.byIcon(Icons.delete);
        await tester.tap(deleteButton);
        await tester.pumpAndSettle();

        // Verify the item is removed
        expect(find.text('Item 1'), findsNothing);
        expect(find.text('No items added yet!'), findsOneWidget);
      });
}