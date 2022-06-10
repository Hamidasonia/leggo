import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leggo/common/styles.dart';

ThemeData tdMain(BuildContext context) => ThemeData(
  primarySwatch: mOrange,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: hWhite,
  textTheme: GoogleFonts.montserratTextTheme(
    Theme.of(context).textTheme,
  ),
  primaryColor: hWhite,
  primaryColorDark: hWhite,
  primaryTextTheme: TextTheme(headline6: TextStyle(color: hWhite)),
  dividerColor: hWhite,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    toolbarTextStyle: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme,
    ).bodyText2,
    titleTextStyle: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme,
    ).headline6,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: Colors.black),
    hintStyle: const TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
);
