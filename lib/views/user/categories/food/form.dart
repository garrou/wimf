import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wimf/models/food.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/food_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/utils/validator.dart';
import 'package:wimf/views/user/home.dart';
import 'package:wimf/widgets/button.dart';
import 'package:wimf/widgets/snackbar.dart';
import 'package:wimf/widgets/textfield.dart';

class FormFoodPage extends StatefulWidget {
  final int categoryId;
  final Food? food;
  const FormFoodPage({Key? key, required this.categoryId, this.food})
      : super(key: key);

  @override
  State<FormFoodPage> createState() => _FormFoodPageState();
}

class _FormFoodPageState extends State<FormFoodPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.food != null
                ? 'Modifier ${widget.food!.name}'
                : 'Ajouter un aliment',
            style: textStyle,
          ),
          actions: [
            Visibility(
              visible: widget.food != null,
              child: IconButton(
                onPressed: () => _showConfirmation(context),
                icon: const Icon(Icons.delete_outline),
              ),
            )
          ],
        ),
        body: FoodForm(categoryId: widget.categoryId, food: widget.food),
      );

  Future _showConfirmation(BuildContext context) async => await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text('Supprimer cet aliment ?'),
          content: const Text('La suppression de cet aliment sera définitive.'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            )
          ],
        ),
      );

  void _delete() async {
    final HttpResponse response = await FoodService().delete(widget.food!.id);

    if (response.success()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const UserHomePage(),
        ),
        ((route) => false),
      );
    }
    snackBar(context, response.message());
  }
}

class FoodForm extends StatefulWidget {
  final int categoryId;
  final Food? food;
  const FoodForm({Key? key, required this.categoryId, this.food})
      : super(key: key);

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _keyForm = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _details = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    _name.text = widget.food?.name ?? '';
    _quantity.text = widget.food?.quantity.toString() ?? '';
    _details.text = widget.food?.details ?? '';
    _selectedDate = widget.food?.freezeAt ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _keyForm,
        child: ListView(
          children: <Widget>[
            AppTextField(
              textfieldController: _name,
              label: 'Nom',
              icon: Icon(Icons.label_outline,
                  color: Theme.of(context).primaryColor),
              keyboardType: TextInputType.text,
              validator: (value) => lengthValidator(value, 1, 255),
            ),
            AppTextField(
              textfieldController: _quantity,
              label: 'Quantité',
              icon: Icon(Icons.numbers_outlined,
                  color: Theme.of(context).primaryColor),
              keyboardType: TextInputType.number,
              validator: (value) => fieldValidator(value),
            ),
            AppTextField(
              textfieldController: _details,
              label: 'Détails (commerce, marque, ...)',
              icon: Icon(Icons.comment_outlined,
                  color: Theme.of(context).primaryColor),
              keyboardType: TextInputType.text,
              validator: (value) => maxLengthValidator(value, 255),
              maxLines: 5,
            ),
            Padding(
              child: Text(
                'Date de congélation',
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.all(10),
            ),
            SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: _selectedDate,
              selectionColor: Theme.of(context).primaryColor,
              todayHighlightColor: Theme.of(context).primaryColor,
              minDate: DateTime(1900),
              maxDate: DateTime.now(),
            ),
            AppButton(
              content: 'Enregistrer',
              onPressed: _onSave,
            )
          ],
        ),
      );

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDate = args.value;
  }

  void _onSave() {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      _save();
    }
  }

  void _save() async {
    Food food = Food(
      widget.food?.id ?? 0,
      _name.text.trim(),
      widget.categoryId,
      int.parse(_quantity.text),
      _details.text.trim(),
      _selectedDate,
    );
    final HttpResponse response = widget.food == null
        ? await FoodService().create(food)
        : await FoodService().update(food);

    if (response.success()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const UserHomePage(),
        ),
        (route) => false,
      );
    }
    snackBar(context, response.message());
  }
}
