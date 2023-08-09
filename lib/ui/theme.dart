import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testtextapp/app.dart';

class AppThemeData {
  static Color themeColorMain = Colors.white;
  static Color themeColorSecondary = Colors.indigo;
  static Color themeColorAccent = Colors.indigoAccent;

  void themeChange() {
    themeColorMain = Colors.blue;
    themeColorSecondary = Colors.pink;
  }
}

class AppTheme extends StatelessWidget{
  final Color themeColorMain;
  final Color themeColorSecondary;
  AppTheme({required this.themeColorMain, required this.themeColorSecondary});

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
        ),
      ),
      home: MyHomePage(),
    );
  }


}