
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/ui/history.dart';
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
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var texts = [];
  var sender = [];
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;
  var eventStream = EventStream();
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MessagePage(eventStream: eventStream,);
        break;
      case 1:
        page = KnowledgeBasePage();
        break;
      case 2:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    leading: Row(
                      children: [
                        const IconButton(icon: Icon(Icons.format_line_spacing), onPressed: null),
                        const Text("NativeGPT"),
                      ],
                    ),
                    extended: constraints.maxWidth >= 600,
                    minWidth: 50,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.message),
                        label: Text('Conversations'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.folder),
                        label: Text('Knowledge base'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                const VerticalDivider(thickness: 2, width: 1, color: Colors.black38,),
                Expanded(
                    child: Container(
                      child: page,
                    )
                )
              ],
            ),
          );
        }
    );
  }
}

