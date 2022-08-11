import 'package:flutter/material.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/user/add/add_food.dart';
import 'package:wimf/views/user/categories/categories.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _current = 0;
  final _screens = [
    const CategoriesPage(),
    const AddFoodPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _screens[_current],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _current,
            onTap: (index) => setState(() => _current = index),
            backgroundColor: primaryColor,
            unselectedItemColor: Colors.white60,
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                label: 'Catégories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_add_outlined),
                label: 'Ajouter',
              ),
            ]),
      );
}
