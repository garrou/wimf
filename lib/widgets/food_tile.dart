import 'package:flutter/material.dart';
import 'package:wimf/models/food.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/user/categories/food/form.dart';

class FoodTile extends StatelessWidget {
  final int categoryId;
  final Food food;
  const FoodTile({Key? key, required this.categoryId, required this.food})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 10,
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      FormFoodPage(categoryId: categoryId, food: food),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: Text('${food.quantity}', style: titleTextStyle),
                title: Text(food.name, style: textStyle),
                subtitle: Text(food.formatFreezeAt(), style: textStyle),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
        ),
      );
}
