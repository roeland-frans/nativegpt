
import 'package:testtextapp/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/ui/history.dart';

import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/ui/card/text.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), // IMPORTANT
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var texts = [];
  var sender = [];
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage();
        break;
      case 1:
        page = MessagePage();
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
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.message),
                        label: Text('Messages'),
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


class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Placeholder',
        ),
      ],
    );
  }
}

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final myController = TextEditingController();
  var eventStream = EventStream();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ChatHistory(eventStream: eventStream,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Message',
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.amber)),
              onPressed: () {
                AppEvent message = AppEvent.textMessage(myController.text, true);
                eventStream.addEvent(message);
                setState(() {

                });
                AppEvent rpmessage = AppEvent.textMessage("respond", false);
              },
              child: Text('Send'),
            ),
          ],
        ),
      ],
    );
  }
}