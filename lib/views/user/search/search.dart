import 'package:flutter/material.dart';
import 'package:wimf/models/food.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/food_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/widgets/error.dart';
import 'package:wimf/widgets/food_tile.dart';
import 'package:wimf/widgets/loading.dart';

final _foodService = FoodService();

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Food>> _foods;

  Future<List<Food>> _loadFoods() async {
    final HttpResponse response = await _foodService.getAll();

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
          title: Text(
            'Chercher mes aliments',
            style: textStyle,
          ),
          actions: [
            IconButton(
              onPressed: () => showSearch(
                context: context,
                delegate: SearchFood(),
              ),
              icon: const Icon(Icons.search_outlined, size: 25),
            ),
          ],
        ),
        body: FutureBuilder<List<Food>>(
          future: _foods,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const AppError();
            } else if (snapshot.hasData) {
              final s = snapshot.data!.length > 1 ? 's' : '';
              return ListView(
                children: <Widget>[
                  Padding(
                    child: Text(
                      '${snapshot.data!.length} aliment$s',
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                    padding: const EdgeInsets.only(top: 10.0),
                  ),
                  Column(
                    children: <Widget>[
                      for (Food food in snapshot.data!)
                        FoodTile(categoryId: food.categoryId, food: food)
                    ],
                  ),
                ],
              );
            }
            return const AppLoading();
          },
        ),
      );
}

class SearchFood extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.cancel, size: 25),
          onPressed: () => query = "",
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back, size: 25),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<List<Food>>(
        future: _foodService.search(query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const AppError();
          } else if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                for (Food food in snapshot.data!)
                  FoodTile(categoryId: food.categoryId, food: food)
              ],
            );
          }
          return const AppLoading();
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
