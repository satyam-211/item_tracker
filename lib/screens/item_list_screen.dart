import 'package:flutter/material.dart';
import 'package:item_tracker/models/item.dart';
import 'package:item_tracker/widgets/item_detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:item_tracker/providers/item_provider.dart';
import 'add_edit_item_screen.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Tracker'),
      ),
      body: Selector<ItemProvider, int>(
        selector: (_, provider) => provider.items.length,
        builder: (context, _, __) {
          final provider = context.read<ItemProvider>();
          final items = provider.items;
          return items.isEmpty
              ? const Center(
                  child: Text('No items added yet!'),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (ctx, index) => Selector<ItemProvider,Item>(
                      selector: (_, provider) => provider.items[index],
                      builder: (context, item, child) =>  ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: ItemDetailWidget(item: item),
                        ),
                        onTap: () => _navigateToEditItem(context, item),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            provider.removeItem(item.id);
                          },
                        ),
                      ),
                    ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddItem(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddEditItemScreen(),
      ),
    );
  }

  void _navigateToEditItem(BuildContext context, Item item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEditItemScreen(item: item),
      ),
    );
  }
}
