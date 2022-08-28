import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wimf/models/category.dart';
import 'package:wimf/models/guard.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/category_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/user/categories/category.dart';
import 'package:wimf/widgets/error.dart';
import 'package:wimf/widgets/loading.dart';
import 'package:wimf/widgets/network_image.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final StreamController<bool> _streamController = StreamController();
  late Future<List<Category>> _categories;

  @override
  void initState() {
    Guard.checkAuth(_streamController);
    _categories = _loadCategories();
    super.initState();
  }

  Future<List<Category>> _loadCategories() async {
    try {
      final HttpResponse response = await CategoryService().getAll();

      if (response.success()) {
        return createCategories(response.content());
      } else {
        throw Exception();
      }
    } on Exception catch (_) {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Catégories', style: textStyle),
        ),
        body: FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const AppError();
            } else if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  for (Category category in snapshot.data!)
                    CategoryTile(category: category)
                ],
              );
            }
            return const AppLoading();
          },
        ),
      );
}

class CategoryTile extends StatelessWidget {
  final Category category;
  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CategoryPage(category: category),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: AppNetworkImage(image: category.image),
              title: Text(category.name, style: textStyle),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        ),
      );
}
