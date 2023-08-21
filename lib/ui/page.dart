import 'package:testtextapp/event.dart';
import 'package:testtextapp/app.dart';
import 'package:testtextapp/ui/history.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:flutter/material.dart';
import 'package:testtextapp/ui/card/navbar.dart';
import 'package:testtextapp/connection.dart';


class MessagePage extends StatefulWidget {
  final EventStream eventStream;
  final AppConnection connection;
  final MyAppState appState;
  MessagePage({required this.eventStream, Key? key, required this.appState, required this.connection,}): super(key: key);
  
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final myController = TextEditingController();

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
                    Padding( // move to Composer
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                          ElevatedButton.icon(
                            icon: Icon(Icons.send),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                  )
                              )
                            ),
                            onPressed: () {
                              widget.connection.publishEvent(AppEvent.textMessage(myController.text));
                              myController.clear();
                              // widget.eventStream.addEvent(message);
                              // setState(() {});
                            },
                            label: Text('Send'),
                          ),
                        ],
                      ),
                    ),
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

class SettingsPage extends StatelessWidget{
  final MyAppState appState;
  final AppConnection connection;
  SettingsPage({required this.appState, required this.connection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),),
      drawer: NavBar(appState: appState,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Settings Placeholder',
          ),
        ],
      ),
    );
  }
}
