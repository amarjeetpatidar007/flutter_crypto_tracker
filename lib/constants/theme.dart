import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black
    )
  )
);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff15161a),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Color(0xff15161a)
  )
);