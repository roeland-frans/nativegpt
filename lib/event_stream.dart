import 'package:testtextapp/event.dart';
import 'package:flutter/material.dart';

class EventStream extends ChangeNotifier{
  final List<AppEvent> events;

  EventStream._({required this.events,});

  factory EventStream({List<AppEvent> events = const []}){
    final eventStream = EventStream._(events: events);
    return eventStream;
  }

}