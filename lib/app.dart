import 'package:testtextapp/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/ui/chat.dart';


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
  final AppEvent appEv = AppEvent();


  void newTexts(message){
    texts.add(message);
    appEv.writeTo(message.text);
    notifyListeners();
  }
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
          'You have pushed the button this many times:',
        ),
        Text(
          'boop',
          style: Theme.of(context).textTheme.headlineMedium,
        )
      ],
    );
  }
}

class MessagePage extends StatelessWidget{

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MessageFeed(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextField(
                // style: TextStyle(fontSize: 40.0, height: 2.0, color: Colors.black),
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
                Message message = Message(text: myController.text, isCurrentUser: true);
                appState.newTexts(message);
                print(appState.texts);
                Message respmessage = Message(text: "respond", isCurrentUser: false);
                appState.newTexts(respmessage);
              },
              child: Text('Send'),
            ),
          ],
        ),
      ],
    );
  }
}

class MessageFeed extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MessageFeedState();
}

class _MessageFeedState extends State<MessageFeed> {
  // look into block
  final AppEvent appEv = AppEvent();
  // final ScrollController _scrollController = ScrollController();
  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    if (appState.texts.isEmpty) {
      return Row(
        children: [
          Text('No messages yet.'),
        ]
      );
    }
    return Flexible(
      child: Scaffold(
        body: ListView(
          // controller: _scrollController,
          controller: _controller,
          children: [
            for (Message pair in appState.texts)
              ChatBubble(
                text: pair.text,
                isCurrentUser: pair.isCurrentUser,
              ),
            // _scrollDown(),

          ],
        ),
      ),
    );
  }
}