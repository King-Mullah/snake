import 'package:flutter/material.dart';
import 'package:snake/screen/HomeScreen.dart';

import 'elements/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.dackTheme,
      home: HomeScreen(),
    );
  }
}

