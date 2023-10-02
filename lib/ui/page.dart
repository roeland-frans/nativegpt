import 'package:testtextapp/event.dart';
import 'package:testtextapp/app.dart';
import 'package:testtextapp/ui/history.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:flutter/material.dart';
import 'package:testtextapp/ui/card/navbar.dart';
import 'package:testtextapp/connection.dart';
import 'package:testtextapp/ui/settings.dart';

import 'composer.dart';



class MessagePage extends StatefulWidget {
  final EventStream eventStream;
  final AppConnection connection;
  final MyAppState appState;
  MessagePage({required this.eventStream, Key? key, required this.appState, required this.connection,}): super(key: key);
  
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversations"),),
      drawer: NavBar(appState: widget.appState,),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              const VerticalDivider(thickness: 2, width: 1, color: Colors.black38,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ChatHistory(eventStream: widget.eventStream,),
                    const Divider(thickness: 1, height: 1, color: Colors.black38,),
                    AppComposer(eventStream: widget.eventStream, connection: widget.connection,)
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class KnowledgeBasePage extends StatelessWidget{
  final MyAppState appState;
  final AppConnection connection;
  KnowledgeBasePage({required this.appState, required this.connection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Knowledge base"),),
      drawer: NavBar(appState: appState,),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Placeholder',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },),
    );
  }
}

class SettingsPage extends StatefulWidget{
  final MyAppState appState;
  final AppConnection connection;
  final BotConnection botConnection;
  SettingsPage({required this.appState, required this.connection, required this.botConnection});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

  int pageIndex = 0;

  Widget pageState() {
    switch (pageIndex) {
      case 1:
        return AdvancedSettingsWidget(connection: widget.connection, botConnection: widget.botConnection, appState: widget.appState,);
      case 2:
        return DisplaySettingsWidget();
      default:
        return GeneralSettingsWidget(connection: widget.connection, botConnection: widget.botConnection, appState: widget.appState,);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        selectedIndex: pageIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'General',
          ),
          NavigationDestination(
            icon: Icon(Icons.handyman),
            label: 'Advanced',
          ),
          NavigationDestination(
            icon: Icon(Icons.computer),
            label: 'Display',
          ),
        ],
      ),
      appBar: AppBar(title: Text("Settings"),),
      drawer: NavBar(appState: widget.appState,),
      body: pageState(),
    );
  }
}
