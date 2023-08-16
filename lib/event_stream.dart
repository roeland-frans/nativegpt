import 'package:testtextapp/event.dart';
import 'package:flutter/material.dart';

class EventStream extends ChangeNotifier{
  static final EventStream eventStream = EventStream._internal(events: []);
  final List<AppEvent> events;



  EventStream._internal({required this.events,});

  factory EventStream(){
    return eventStream;
  }

  void addEvent(event){
    events.add(event);
    notifyListeners();
  }

}