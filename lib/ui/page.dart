import 'package:testtextapp/event.dart';
import 'package:testtextapp/app.dart';
import 'package:testtextapp/ui/history.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  final EventStream eventStream;
  MessagePage({required this.eventStream, Key? key,}): super(key: key);
  
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final myController = TextEditingController();
  // var eventStream = EventStream();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ChatHistory(eventStream: widget.eventStream,),
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
                widget.eventStream.addEvent(message);
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

class KnowledgeBasePage extends StatelessWidget{
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

class SettingsPage extends StatelessWidget{
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
