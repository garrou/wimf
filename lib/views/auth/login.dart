import 'package:flutter/material.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/auth_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/utils/storage.dart';
import 'package:wimf/utils/validator.dart';
import 'package:wimf/views/auth/register.dart';
import 'package:wimf/views/user/home.dart';
import 'package:wimf/widgets/button.dart';
import 'package:wimf/widgets/link.dart';
import 'package:wimf/widgets/snackbar.dart';
import 'package:wimf/widgets/textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(
            children: <Widget>[
              Image.asset('assets/login.png', height: 200),
              Padding(
                child: Text(
                  'Se connecter',
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                padding: const EdgeInsets.only(top: 10),
              ),
              const LoginForm()
            ],
          ),
        ),
      );
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _keyForm = GlobalKey<FormState>();

  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Form(
          key: _keyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppTextField(
                keyboardType: TextInputType.text,
                label: "Nom d'utilisateur",
                textfieldController: _username,
                validator: fieldValidator,
                icon: Icon(
                  Icons.person_outline_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              AppTextField(
                keyboardType: TextInputType.text,
                label: 'Mot de passe',
                textfieldController: _password,
                validator: fieldValidator,
                obscureText: true,
                icon: Icon(
                  Icons.password_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              AppButton(
                content: 'Connexion',
                onPressed: _onLogin,
              ),
              AppLink(
                child: Text('Nouveau ? Créer un compte', style: linkTextStyle),
                destination: const RegisterPage(),
              ),
            ],
          ),
        ),
      );

  void _onLogin() {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      _login();
    }
  }

  void _login() async {
    final HttpResponse response =
        await AuthService().login(_username.text.trim(), _password.text.trim());

    if (response.success()) {
      Storage.setToken(response.content());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const UserHomePage(),
          ),
          (route) => false);
    } else {
      _password.text = '';
      snackBar(context, response.message());
    }
  }
}
