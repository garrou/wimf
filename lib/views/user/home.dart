import 'package:flutter/material.dart';
import 'package:wimf/views/user/add/add_food.dart';
import 'package:wimf/views/user/categories/categories.dart';
import 'package:wimf/views/user/profile/profile.dart';
import 'package:wimf/views/user/search/search.dart';

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
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _screens[_current],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _current,
            onTap: (index) => setState(() => _current = index),
            backgroundColor: Theme.of(context).primaryColor,
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
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: 'Chercher',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                label: 'Profil',
              ),
            ]),
      );
}
