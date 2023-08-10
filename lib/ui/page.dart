import 'package:testtextapp/event.dart';
import 'package:testtextapp/app.dart';
import 'package:testtextapp/ui/history.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  final EventStream eventStream;
  final String title;
  MessagePage({required this.eventStream, required this.title, Key? key,}): super(key: key);
  
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                  const Divider(thickness: 2, height: 1, color: Colors.black38,),
                  Padding(
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
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                  )
                              )
                          ),
                          onPressed: () {
                            AppEvent message = AppEvent.textMessage(myController.text, true);
                            widget.eventStream.addEvent(message);
                            setState(() {});
                            AppEvent rpmessage = AppEvent.textMessage("respond", false);
                            widget.eventStream.addEvent(rpmessage);
                            setState(() {});
                          },
                          child: Text('Send',),
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
    );
  }
}

class KnowledgeBasePage extends StatelessWidget{
  final String title;
  KnowledgeBasePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
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
  final String title;
  SettingsPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Settings Placeholder',
        ),
      ],
    );
  }
}
