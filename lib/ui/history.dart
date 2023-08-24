import 'package:flutter/material.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/ui/card/text.dart';
import 'package:testtextapp/ui/presence/user_avatar.dart';
import 'package:testtextapp/actordata.dart';




class ChatHistory extends StatelessWidget {
  final EventStream eventStream;
  final ScrollController _controller = ScrollController();

  ChatHistory({required this.eventStream});

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }
  @override
  Widget build(BuildContext context) {
    // var eventStream = context.watch<EventStream>();
    if (eventStream.events.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            children: [
              Text('No messages yet.'),
            ]
        ),
      );
    }
    return Flexible(
      child: Scaffold(
        body: ListView.builder(
          reverse: true,
          controller: _controller,
          itemCount: eventStream.events.length,
          itemBuilder: (context, index) {
            switch (eventStream.events[index].type) {
              case 'nativegpt.event.textMessage':
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      BuildAvatar(userData: eventStream.userData[eventStream.events[index].id]!),
                      ChatBubble(
                        text: eventStream.events[index].data['text'],
                        userData: eventStream.userData[eventStream.events[index].id]!,
                      ),
                    ],
                  ),
                );
              default:
                return null;
            }
          },
          // controller: _scrollController,
        ),
      ),
    );
  }
}
