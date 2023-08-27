import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/connection.dart';
import 'package:testtextapp/ui/theme.dart';

import '../actordata.dart';
import '../app.dart';
import '../event.dart';
import 'history.dart';

enum _AppComposerMode { text, extra, image }

class AppComposer extends StatefulWidget{
  final EventStream eventStream;
  final AppConnection connection;

  const AppComposer({
    required this.eventStream,
    required this.connection,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppComposerState();
}

class _AppComposerState extends State<AppComposer>{
  TextEditingController myController = TextEditingController();
  FocusNode composerFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _AppTextMode(eventStream: widget.eventStream, connection: widget.connection, myController: myController);
  }
}

class _AppTextMode extends StatefulWidget {
  final EventStream eventStream;
  final AppConnection connection;
  final TextEditingController myController;

  const _AppTextMode({
    required this.eventStream,
    required this.connection,
    required this.myController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppTextModeState();
}

class _AppTextModeState extends State<_AppTextMode> {

  FocusNode composerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              child: TextFormField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 8,
                controller: widget.myController,
                focusNode: composerFocusNode,
                onFieldSubmitted: (_) async {
                  widget.connection.publishEvent(
                    AppEvent.textMessage(
                        widget.myController.text, ActorData.userID
                    ),
                  );
                  widget.myController.clear();
                  composerFocusNode.requestFocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Message',
                ),
              ),
              onKey: (RawKeyEvent keyEvent) {
                if (keyEvent.logicalKey == LogicalKeyboardKey.tab){
                  widget.connection.publishEvent(
                    AppEvent.textMessage(
                        widget.myController.text, ActorData.userID
                    ),
                  );
                  widget.myController.clear();
                  composerFocusNode.unfocus();
                }
              },
            ),
          ),
          SizedBox(width: 10),
          _AppSendTextButton(
              eventStream: widget.eventStream,
              connection: widget.connection,
              textEditingController: widget.myController,
              composerFocusNode: composerFocusNode
          )
        ],
      ),
    );
  }
}

class _AppSendTextButton extends StatelessWidget {
  final EventStream eventStream;
  final AppConnection connection;
  final TextEditingController textEditingController;
  final FocusNode composerFocusNode;

  const _AppSendTextButton({
    required this.eventStream,
    required this.connection,
    required this.textEditingController,
    required this.composerFocusNode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.send),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              )
          )
      ),
      onPressed: () {
        connection.publishEvent(AppEvent.textMessage(textEditingController.text, ActorData.userID));
        textEditingController.clear();
        connection.publishEvent(AppEvent.textMessage('test response', ActorData.botID));
        composerFocusNode.unfocus();
      },
      label: Text('Send'),
      // color: AppThemePalette.themeColorBase,
    );
  }
}
