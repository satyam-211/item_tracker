import 'package:flutter/material.dart';
import 'package:item_tracker/providers/item_provider.dart';
import 'package:item_tracker/screens/item_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ItemTrackerApp());
}

class ItemTrackerApp extends StatelessWidget {
  const ItemTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: const MaterialApp(
        title: 'Item Tracker',
        home: ItemListScreen(),
      ),
    );
  }
}
