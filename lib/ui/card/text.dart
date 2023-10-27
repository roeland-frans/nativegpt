import 'package:flutter/material.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/ui/theme.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.userData,
  }) : super(key: key);
  final String text;
  final AppUserData userData;


  @override
  Widget build(BuildContext context) {
    bool isCurrentUser;
    double maxWidth = MediaQuery.of(context).size.width*0.8;

    if (userData.type == UserType.user){
      isCurrentUser = true;
    } else {
      isCurrentUser = false;
    }

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
            border: Border.all(color: isCurrentUser ? AppThemePalette.themeColorBase : AppThemePalette.themeColorAccent, width: 2),
            color: isCurrentUser ? AppThemePalette.themeColorMain : AppThemePalette.themeColorLighter,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SelectableText(
              text,
              enableInteractiveSelection: true,
              textWidthBasis: TextWidthBasis.parent,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: isCurrentUser ? AppThemePalette.textColor : AppThemePalette.textColor),
            ),
          ),
        ),
      ),
    );
  }
}