import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 12.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 12.0,
        4,
      ),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerLeft : Alignment.centerRight,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            border: Border.all(color: isCurrentUser ? Colors.grey : Colors.indigoAccent, width: 2),
            color: isCurrentUser ? Colors.white : Colors.indigo[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: isCurrentUser ? Colors.black87 : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}