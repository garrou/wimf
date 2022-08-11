import 'package:flutter/material.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'WIMF',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
          backgroundColor: Colors.white,
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: primaryColor, // Change bubble to red
            cursorColor: primaryColor,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: primaryColor,
            actionTextColor: Colors.white,
            contentTextStyle: TextStyle(color: Colors.white),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
          appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
        ),
        home: const HomePage(),
      );
}
