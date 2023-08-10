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
              backgroundColor: themeColorSecondary
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
            ),
            elevation: 1),
        indicatorColor: themeColorSecondary,
        highlightColor: themeColorSecondary,
        drawerTheme: DrawerThemeData(
          backgroundColor: themeColorMain,
        ),
        listTileTheme: ListTileThemeData(
          selectedColor: themeColorSecondary
        )
      ),
      home: MyHomePage(),
    );
  }


}