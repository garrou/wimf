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

const double size = 15;

TextStyle textStyle = GoogleFonts.roboto(fontSize: size);
TextStyle titleTextStyle = GoogleFonts.roboto(fontSize: 25);
TextStyle linkTextStyle = GoogleFonts.roboto(
  fontSize: size,
  color: primaryColor,
  decoration: TextDecoration.underline,
);
