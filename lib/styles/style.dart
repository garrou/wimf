import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wimf/main.dart';

ButtonStyle roundedStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: primaryColor),
    ),
  ),
  backgroundColor: MaterialStateProperty.all(primaryColor),
);

TextStyle textStyle = GoogleFonts.roboto(fontSize: 20);
TextStyle titleTextStyle = GoogleFonts.roboto(fontSize: 30);
TextStyle linkTextStyle = GoogleFonts.roboto(fontSize: 20, color: primaryColor);
