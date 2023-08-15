import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtextapp/ui/page.dart';
import 'package:testtextapp/ui/theme.dart';
import 'package:testtextapp/event_stream.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: AppTheme(
        themeColorMain: AppThemePalette.themeColorMain,
        themeColorSecondary: AppThemePalette.themeColorSecondary,
        themeColorAccent: AppThemePalette.themeColorAccent,
        themeColorBase: AppThemePalette.themeColorBase,
        textColor: AppThemePalette.textColor,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var selectedIndex = 0;

  void onItemTapped(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var eventStream = EventStream();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Widget page;
    switch (appState.selectedIndex) {
      case 0:
        page = MessagePage(eventStream: eventStream, appState: appState,);
        break;
      case 1:
        page = KnowledgeBasePage(appState: appState,);
        break;
      case 2:
        page = SettingsPage(appState: appState,);
        break;
      default:
        throw UnimplementedError('no widget for ${appState.selectedIndex}');
    }

    return Scaffold(
      body: page,
    );
  }
}

