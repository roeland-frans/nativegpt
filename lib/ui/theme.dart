import 'package:flutter/material.dart';
import 'package:testtextapp/app.dart';

class AppThemePalette {
  static Color themeColorMain = Colors.white;
  static Color themeColorSecondary = Colors.indigo;
  static Color themeColorLighter = Colors.indigo.shade200;
  static Color themeColorAccent = Colors.indigoAccent;
  static Color themeColorBase = Colors.grey;
  static Color textColor = Colors.black;
}

class AppThemeProvider extends StatelessWidget{
  final Widget child;

  AppThemeProvider({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return AppThemeInherited(
      theme: AppTheme(
        themeColorMain: AppThemePalette.themeColorMain,
        themeColorSecondary: AppThemePalette.themeColorSecondary,
        themeColorAccent: AppThemePalette.themeColorAccent,
        themeColorBase: AppThemePalette.themeColorBase,
        textColor: AppThemePalette.textColor,
      ),
      child: child,
    );
  }
}

class AppThemeInherited extends InheritedWidget{
  final AppTheme theme;

  AppThemeInherited({required this.theme, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(AppThemeInherited oldWidget) =>
      theme != oldWidget.theme;
  
}

class AppTheme{
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

  ThemeData themeData() => ThemeData(
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
    ),
  );

  static AppTheme of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppThemeInherited>()!
        .theme;
  }

  Widget builder(BuildContext context, Widget? child) {
    return AppThemeInherited(
      theme: this,
      child: child!,
    );
  }
}