import 'package:testtextapp/event.dart';
import 'package:flutter/material.dart';

class EventStream {
  final List<AppEvent> events;
  final bool Function(AppEvent event) messageEvent;

  EventStream._({
    required this.events,
    required this.messageEvent,
  });

  factory EventStream({
    String? gridUserId,
    List<AppEvent> events = const [],
  }) {
    final messageEvent = _messageSent(gridUserId);
    final eventStream = EventStream._(
      events: events,
      messageEvent: messageEvent,
    );
    return eventStream;
}

  static bool Function(AppEvent event) _messageSent(String? gridUserId) {
    print("e");
    return (event) => [
      'nativegpt.event.textMessage'
    ].contains(event.type);
  }
}