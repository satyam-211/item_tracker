import 'package:flutter/material.dart';
import 'package:item_tracker/models/item.dart';

class ItemProvider with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => [..._items];

  void addItem(String name, String description) {
    final newItem = Item(name: name, description: description);
    _items.add(newItem);
    notifyListeners();
  }

  void editItem(String id, String newName, String newDescription) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        name: newName,
        description: newDescription
      );
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Item? getItemById(String id) {
    try{
      return _items.firstWhere((item) => item.id == id);
    }catch (e){
      return null;
    }
  }
}