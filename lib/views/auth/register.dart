import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/utils/validator.dart';
import 'package:wimf/views/auth/login.dart';
import 'package:wimf/widgets/button.dart';
import 'package:wimf/widgets/link.dart';
import 'package:wimf/widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) => Scaffold(body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          children: <Widget>[
            SvgPicture.asset(
              'assets/walk.svg',
              semanticsLabel: 'Logo',
              height: 200,
            ),
            Padding( 
              child: Text(
                "S'inscrire",
                style: titleTextStyle,
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.only(top: 10),
            ),
            const RegisterForm()
          ],
        ),
      ),);
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({ Key? key }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _keyForm = GlobalKey<FormState>();

  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Form(
          key: _keyForm,
          child: Column(
            children: <Widget>[
              AppTextField(
                keyboardType: TextInputType.text,
                label: "Nom d'utilisateur",
                textfieldController: _username,
                validator: (value) => lengthValidator(value, 3, 50),
                icon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              AppTextField(
                keyboardType: TextInputType.text,
                label: 'Mot de passe',
                textfieldController: _password,
                validator: (value) => lengthValidator(value, 8, 50),
                obscureText: true,
                icon: Icon(
                  Icons.password_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              AppTextField(
                keyboardType: TextInputType.text,
                label: 'Confirmer le mot de passe',
                textfieldController: _confirm,
                // ignore: body_might_complete_normally_nullable
                validator: (value) {
                  if (_password.text != value || value!.isEmpty) {
                    return 'Mot de passe incorrect';
                  }
                },
                obscureText: true,
                icon: Icon(
                  Icons.password_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              AppButton(
                content: "S'inscrire",
                onPressed: _onRegister,
              ),
              AppLink(
                child: Text('Déjà membre ? Se connecter', style: linkTextStyle),
                destination: const LoginPage(),
              ),
            ],
          ),
        ),
      );

  void _onRegister() {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      _register();
    }
  }

  void _register() async {
    /*
    HttpResponse response = await AuthService().register(UserRegister(
        _username.text, _password.text, _confirm.text));

    if (response.success()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        ),
      );
    }
    snackBar(context, response.message());
    */
  }
}