import 'package:flutter/material.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/models/user.dart';
import 'package:wimf/services/user_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/utils/validator.dart';
import 'package:wimf/widgets/button.dart';
import 'package:wimf/widgets/snackbar.dart';
import 'package:wimf/widgets/textfield.dart';

class UpdateUsernamePage extends StatefulWidget {
  final User user;
  const UpdateUsernamePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateUsernamePage> createState() => _UpdateUsernamePageState();
}

class _UpdateUsernamePageState extends State<UpdateUsernamePage> {
  final _keyForm = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void initState() {
    _name.text = widget.user.username;
    super.initState();
  }

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
                icon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).primaryColor,
                ),
                keyboardType: TextInputType.text,
                label: "Nom d'utilisateur",
                textfieldController: _name,
                validator: (value) => lengthValidator(value, 3, 50),
              ),
              AppTextField(
                icon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).primaryColor,
                ),
                keyboardType: TextInputType.text,
                label: "Nom d'utilisateur",
                textfieldController: _confirm,
                validator: (value) {
                  if (_name.text != value || value!.isEmpty) {
                    return 'Noms différents';
                  }
                },
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
    final HttpResponse response =
        await UserService().updateUsername(_name.text.trim(), _confirm.text.trim());

    if (response.success()) {
      Navigator.pop(context);
    }
    snackBar(context, response.message());
  }
}
