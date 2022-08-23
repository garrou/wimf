import 'package:flutter/material.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/user_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/utils/validator.dart';
import 'package:wimf/widgets/button.dart';
import 'package:wimf/widgets/snackbar.dart';
import 'package:wimf/widgets/textfield.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _keyForm = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Modifier mon identifiant', style: textStyle),
        ),
        body: Form(
          key: _keyForm,
          child: Column(
            children: <Widget>[
              AppTextField(
                keyboardType: TextInputType.text,
                label: 'Mot de passe actuel',
                textfieldController: _current,
                obscureText: true,
                icon: Icon(
                  Icons.password_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              AppTextField(
                keyboardType: TextInputType.text,
                label: 'Nouveau mot de passe',
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
                label: 'Confirmer le nouveau mot de passe',
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
                content: "Enregistrer",
                onPressed: _onSave,
              ),
            ],
          ),
        ),
      );

  void _onSave() {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      _save();
    }
  }

  void _save() async {
    final HttpResponse response = await UserService().updatePassword(
      _current.text.trim(),
      _password.text.trim(),
      _confirm.text.trim(),
    );

    if (response.success()) {
      Navigator.pop(context);
    } else {
      _current.text = '';
      _password.text = '';
      _confirm.text = '';
    }
    snackBar(context, response.message());
  }
}
