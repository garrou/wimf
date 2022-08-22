import 'package:flutter/material.dart';
import 'package:wimf/utils/storage.dart';
import 'package:wimf/views/auth/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Storage.removeToken();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
      );
}
