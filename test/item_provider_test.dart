import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/providers/item_provider.dart';

void main(){
  group('ItemProvider Tests', () {
    late ItemProvider itemProvider;

    setUp(() {
      itemProvider = ItemProvider();
    });

    test('Initial items list should be empty', () {
      expect(itemProvider.items.length, 0);
    });

    test('Adding an item increases the items list', () {
      itemProvider.addItem('Item 1', 'Description 1');
      expect(itemProvider.items.length, 1);
      expect(itemProvider.items[0].name, 'Item 1');
    });

    test('Editing an item updates the item details', () {
      itemProvider.addItem('Item 1', 'Description 1');
      final itemId = itemProvider.items[0].id;
      itemProvider.editItem(itemId, 'Updated Item', 'Updated Description');
      final updatedItem = itemProvider.getItemById(itemId);
      expect(updatedItem?.name, 'Updated Item');
      expect(updatedItem?.description, 'Updated Description');
    });

    test('Removing an item decreases the items list', () {
      itemProvider.addItem('Item 1', 'Description 1');
      itemProvider.addItem('Item 2', 'Description 2');
      final itemId = itemProvider.items[0].id;
      itemProvider.removeItem(itemId);
      expect(itemProvider.items.length, 1);
      expect(itemProvider.items[0].name, 'Item 2');
    });

    test('Getting an item by ID returns the correct item', () {
      itemProvider.addItem('Item 1', 'Description 1');
      final itemId = itemProvider.items[0].id;
      final item = itemProvider.getItemById(itemId);
      expect(item, isNotNull);
      expect(item?.name, 'Item 1');
    });

    test('Editing a non-existent item does nothing', () {
      itemProvider.addItem('Item 1', 'Description 1');
      itemProvider.editItem('non-existent-id', 'New Name', 'New Description');
      expect(itemProvider.items.length, 1);
      expect(itemProvider.items[0].name, 'Item 1');
    });

    test('Removing a non-existent item does nothing', () {
      itemProvider.addItem('Item 1', 'Description 1');
      itemProvider.removeItem('non-existent-id');
      expect(itemProvider.items.length, 1);
    });
  });
}