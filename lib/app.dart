
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/ui/page.dart';
import 'package:testtextapp/ui/theme.dart';
import 'package:testtextapp/event_stream.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), // IMPORTANT
      child: AppTheme(
        themeColorMain: AppThemeData.themeColorMain,
        themeColorSecondary: AppThemeData.themeColorSecondary,
        themeColorAccent: AppThemeData.themeColorAccent,
        themeColorBase: AppThemeData.themeColorBase,
        textColor: AppThemeData.textColor,
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
        page = MessagePage(eventStream: eventStream, title: "Conversations", appState: appState,);
        break;
      case 1:
        page = KnowledgeBasePage(title: "Knowledge base", appState: appState,);
        break;
      case 2:
        page = SettingsPage(title: "Settings", appState: appState,);
        break;
      default:
        throw UnimplementedError('no widget for ${appState.selectedIndex}');
    }

    return Scaffold(
      body: page,
    );
  }
}

