import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wimf/models/category.dart';
import 'package:wimf/models/guard.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/category_service.dart';
import 'package:wimf/widgets/loading.dart';

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
        body: FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // TODO: error
            } else if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  for (Category category in snapshot.data!)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Image.asset('assets/${category.image}'),
                    )
                ],
              );
            }
            return const AppLoading();
          },
        ),
      );
}
