import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Colors.amber[600]!,
    secondary: Colors.red,
    onPrimary: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: Colors.amber[300]!,
    secondary: Colors.red,
    surface: Colors.grey[800]!,
  ),
);
