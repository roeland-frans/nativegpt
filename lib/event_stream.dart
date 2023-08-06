import 'package:testtextapp/event.dart';
import 'package:flutter/material.dart';

class EventStream extends ChangeNotifier{
  static final EventStream eventStream = EventStream._internal(events: []);
  final List<AppEvent> events;

  factory EventStream(){
    return eventStream;
  }

  EventStream._internal({required this.events,});

  void addEvent(event){
    print("yes");
    events.add(event);
    print(events[0].data);
    notifyListeners();
    print(events);
  }

}