import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testtextapp/app.dart';

class AppThemeData {
  static Color themeColorMain = Colors.white;
  static Color themeColorSecondary = Colors.indigo;
  static Color themeColorAccent = Colors.indigoAccent;
  static Color themeColorBase = Colors.grey;
  static Color textColor = Colors.black;

  void themeChange() {
    themeColorMain = Colors.blue;
    themeColorSecondary = Colors.pink;
  }
}

class AppTheme extends StatelessWidget{
  final Color themeColorMain;
  final Color themeColorSecondary;
  final Color themeColorAccent;
  final Color themeColorBase;
  final Color textColor;
  AppTheme({
    required this.themeColorMain,
    required this.themeColorSecondary,
    required this.themeColorAccent,
    required this.themeColorBase,
    required this.textColor});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NativeGPT',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: themeColorMain,
            )),
        textSelectionTheme: TextSelectionThemeData(selectionColor: themeColorSecondary),
        appBarTheme: AppBarTheme(
            color: themeColorMain,
            iconTheme: IconThemeData(
              color: themeColorBase
            ),
            titleTextStyle: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
            )),
        indicatorColor: themeColorSecondary,
        highlightColor: themeColorSecondary,
        navigationRailTheme: NavigationRailThemeData(
            backgroundColor: themeColorMain,
            selectedIconTheme: IconThemeData(
              color: themeColorSecondary
            ),
            selectedLabelTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeColorSecondary
            )),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
        )),
      home: MyHomePage(),
    );
  }


}