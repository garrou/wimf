import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wimf/models/category.dart';
import 'package:wimf/models/food.dart';
import 'package:wimf/models/http_response.dart';
import 'package:wimf/services/category_service.dart';
import 'package:wimf/services/food_service.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/utils/validator.dart';
import 'package:wimf/views/user/home.dart';
import 'package:wimf/widgets/button.dart';
import 'package:wimf/widgets/loading.dart';
import 'package:wimf/widgets/snackbar.dart';
import 'package:wimf/widgets/textfield.dart';

class AddFoodPage extends StatelessWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Ajouter un aliment', style: textStyle),
        ),
        body: const AddFoodForm(),
      );
}

class AddFoodForm extends StatefulWidget {
  const AddFoodForm({Key? key}) : super(key: key);

  @override
  State<AddFoodForm> createState() => _AddFoodFormState();
}

class _AddFoodFormState extends State<AddFoodForm> {
  final _keyForm = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _details = TextEditingController();

  late final Future<List<Category>> _categories;
  Category? _category;

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _categories = _loadCategories();
  }

  Future<List<Category>> _loadCategories() async {
    final HttpResponse response = await CategoryService().getAll();

    if (response.success()) {
      return createCategories(response.content());
    } else {
      throw Exception(response.message());
    }
  }

  Widget _buildCategories(BuildContext context) =>
      FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Erreur de connexion');
            } else if (snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (Category category in snapshot.data!)
                          Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Radio<Category>(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: category,
                                      groupValue: _category,
                                      onChanged: (Category? value) {
                                        setState(() => _category = value);
                                      }),
                                  Text(category.name, style: textStyle)
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ));
            }
            return const AppLoading();
          });

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
            ),
            _buildCategories(context),
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
              initialSelectedDate: DateTime.now(),
              selectionColor: Theme.of(context).primaryColor,
              todayHighlightColor: Theme.of(context).primaryColor,
            ),
            AppButton(
              content: 'Enregistrer',
              onPressed: _onAddFood,
            )
          ],
        ),
      );

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDate = args.value;
  }

  void _onAddFood() {
    if (_keyForm.currentState!.validate() && _category != null) {
      _keyForm.currentState!.save();
      _addFood();
    } else {
      snackBar(context, 'Données invalides');
    }
  }

  void _addFood() async {
    Food food = Food(_name.text.trim(), _category!.id,
        int.parse(_quantity.text), _details.text.trim(), _selectedDate);
    final HttpResponse response = await FoodService().create(food);

    if (response.success()) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const UserHomePage()),
          (route) => false);
    }
    snackBar(context, response.message());
  }
}
