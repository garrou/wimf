import 'package:flutter/material.dart';
import 'package:wimf/models/category.dart';
import 'package:wimf/models/food.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/food_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/user/categories/food/form.dart';
import 'package:wimf/widgets/error.dart';
import 'package:wimf/widgets/food_tile.dart';
import 'package:wimf/widgets/loading.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<Food>> _foods;

  Future<List<Food>> _loadFoods() async {
    final HttpResponse response =
        await FoodService().getByCategory(widget.category.id);

    if (response.success()) {
      return createFoods(response.content());
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    _foods = _loadFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name, style: textStyle),
        ),
        body: FutureBuilder<List<Food>>(
          future: _foods,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const AppError();
            } else if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  for (Food food in snapshot.data!)
                    FoodTile(categoryId: widget.category.id, food: food)
                ],
              );
            }
            return const AppLoading();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    FormFoodPage(categoryId: widget.category.id),
              ),
            );
          },
          child: const Icon(Icons.add_outlined),
        ),
      );
}
