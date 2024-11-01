import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:item_tracker/models/item.dart';
import 'package:item_tracker/providers/item_provider.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;

  const AddEditItemScreen({super.key, this.item});

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  late final ItemProvider itemProvider;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';

  @override
  void initState() {
    super.initState();
    itemProvider = context.read<ItemProvider>();
    if (widget.item != null) {
      _name = widget.item!.name;
      _description = widget.item!.description;
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.item == null) {
        itemProvider.addItem(_name, _description);
      } else {
        itemProvider.editItem(widget.item!.id, _name, _description);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Item' : 'Add Item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _name = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  _description = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
