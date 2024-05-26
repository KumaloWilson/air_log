import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,



);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
// colorScheme: ColorScheme(brightness: Brightness.dark, primary: Colors.grey, onPrimary: Colors.grey, secondary: Colors.grey, onSecondary: Colors.grey, error: Colors.red, onError: Colors.red, background: Colors.grey, onBackground: Colors.grey, surface: Colors.grey, onSurface: Colors.grey,),
  switchTheme:  SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      overlayColor: MaterialStateProperty.all<Color>(Colors.black26),
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black.withOpacity(0.1),
  ),


);

