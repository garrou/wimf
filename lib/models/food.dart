import 'package:intl/intl.dart';
import 'package:wimf/utils/extensions.dart';

class Food {
  final DateFormat _df = DateFormat('dd/MM/yyyy');

  final int id;
  final String name;
  final int categoryId;
  final int quantity;
  final String details;
  final DateTime freezeAt;

  Food(this.id, this.name, this.categoryId, this.quantity, this.details,
      this.freezeAt);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name.toTitleCase(),
        'categoryId': categoryId,
        'quantity': quantity,
        'details': details.toCapitalized(),
        'freezeAt': freezeAt.toUtc().toIso8601String()
      };

  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        categoryId = json['categoryId'],
        quantity = json['quantity'],
        details = json['details'],
        freezeAt = DateTime.parse(json['freezeAt']);

  String formatFreezeAt() => _df.format(freezeAt);
}

List<Food> createFoods(List<dynamic>? records) => records == null
    ? List.empty()
    : records.map((json) => Food.fromJson(json)).toList(growable: false);
