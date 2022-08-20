import 'package:flutter/material.dart';
import 'package:wimf/models/category.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/user/add/add_food.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name, style: textStyle),
        ),
        body: Column(
          children: const <Widget>[
            Text('coucou'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AddFoodPage(),
              ),
            );
          },
          child: const Icon(
            Icons.add_outlined,
          ),
        ),
      );
}
