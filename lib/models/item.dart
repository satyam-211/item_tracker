import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
class Item {
  final String id;
  final String name;
  final String description;

  Item({
    String? id,
    required this.name,
    required this.description,
  }) : id = id ?? const Uuid().v4();

  Item copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return Item(
      name: name ?? this.name,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
