import 'package:intl/intl.dart';

class Food {
  final DateFormat _df = DateFormat('dd/MM/yyyy');

  final int id;
  final String name;
  final int categoryId;
  final int quantity;
  final DateTime freezeAt;

  Food(this.id, this.name, this.categoryId, this.quantity, this.freezeAt);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'categoryId': categoryId,
        'freezeAt': freezeAt.toUtc().toIso8601String()
      };

  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        quantity = json['quantity'],
        categoryId = json['categoryId'],
        freezeAt = json['freezeAt'];

  String formatFreezeAt() => _df.format(freezeAt);
}

List<Food> createFoods(List<dynamic>? records) => records == null
    ? List.empty()
    : records.map((json) => Food.fromJson(json)).toList(growable: false);
