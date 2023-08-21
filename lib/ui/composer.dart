import 'package:flutter/material.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/connection.dart';

class AppComposer extends StatefulWidget{
  final EventStream eventStream;
  final AppConnection connection;

  const AppComposer({
    required this.eventStream,
    required this.connection,
    Key? key,
  }) : super(key: key);

  @override
  _AppComposerState createState() => _AppComposerState();
}

class _AppComposerState extends State<AppComposer>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}