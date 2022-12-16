import 'package:flutter/material.dart';

class MyTheme{
  static final lightTheme= ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.dark(),
  );
  static final dackTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.black,
  );
}