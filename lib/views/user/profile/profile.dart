import 'package:flutter/material.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/models/user.dart';
import 'package:wimf/services/user_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/utils/storage.dart';
import 'package:wimf/views/auth/login.dart';
import 'package:wimf/views/user/profile/update_password.dart';
import 'package:wimf/views/user/profile/update_username.dart';
import 'package:wimf/widgets/error.dart';
import 'package:wimf/widgets/loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Mon profil', style: textStyle),
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
        body: const ProfileTiles(),
      );
}

class ProfileTiles extends StatefulWidget {
  const ProfileTiles({Key? key}) : super(key: key);

  @override
  State<ProfileTiles> createState() => _ProfileTilesState();
}

class _ProfileTilesState extends State<ProfileTiles> {
  late Future<User> _user;

  Future<User> _loadUser() async {
    final HttpResponse response = await UserService().getUser();

    if (response.success()) {
      return User.fromJson(response.content());
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    _user = _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<User>(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError();
        } else if (snapshot.hasData) {
          return ListView(
            children: <Widget>[
              ProfileTile(
                destination: UpdateUsernamePage(user: snapshot.data!),
                icon: const Icon(Icons.person_outline),
                title: 'Modifier votre identifiant',
              ),
              const ProfileTile(
                destination: UpdatePasswordPage(),
                icon: Icon(Icons.password_outlined),
                title: 'Modifier votre mot de passe',
              )
            ],
          );
        }
        return const AppLoading();
      });
}

class ProfileTile extends StatelessWidget {
  final Widget destination;
  final Icon icon;
  final String title;
  const ProfileTile(
      {Key? key,
      required this.destination,
      required this.icon,
      required this.title})
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
                    builder: (BuildContext context) => destination),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: icon,
                title: Text(title, style: textStyle),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
        ),
      );
}
