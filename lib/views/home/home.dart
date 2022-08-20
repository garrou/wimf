import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guards/flutter_guards.dart';
import 'package:wimf/models/guard.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/auth/login.dart';
import 'package:wimf/views/home/discover.dart';
import 'package:wimf/views/user/home.dart';
import 'package:wimf/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<bool> _streamController = StreamController();

  @override
  void initState() {
    Guard.checkAuth(_streamController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AuthGuard(
          authStream: _streamController.stream,
          signedIn: const UserHomePage(),
          signedOut: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.png', height: 300),
                Padding(
                  child: Text("What's In My Freezer ?", style: titleTextStyle),
                  padding: const EdgeInsets.all(20),
                ),
                AppButton(
                  content: 'Découvrir',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const DiscoverPage(),
                    ),
                  ),
                ),
                AppButton(
                  content: 'Se connecter',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
