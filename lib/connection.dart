import 'dart:collection';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/event_emitter.dart';
import 'package:testtextapp/ui/card/avatar.dart';


class AppConnection {
  final EventEmitter _eventEmitter = EventEmitter();
  EventStream _eventStream = EventStream();

  bool firstConnect = true;

  void addOrbListener(String type, Function listener) =>
      _eventEmitter.on(type, listener);

  void removeOrbListener(String type, Function listener) =>
      _eventEmitter.off(type, listener);

  void connect() {
    if (firstConnect) {
      // final allData = {
      //   'userid': {
      //     'user': {
      //       'name': null,
      //       'avatar': null,
      //       'type': 'user',
      //     },
      //   },
      // };
      final allData = AppUserData.userDataTemp("testid", 'setup', null, 'bot');
      final userdata = (allData
      as Map<dynamic, dynamic>? ??
          {})
          .map((key, value) => MapEntry(key, AppUserData.fromMap(value)))
          .cast<String, AppUserData>();
      _receiveAllEvents(
        receiveBuffer: [AppEvent.connect()],
        userdata: <String, AppUserData>{
          ..._eventStream.userData,
          ...userdata,
        },
        emit: () => _eventEmitter.emit(
          firstConnect ? 'firstConnect' : 'reconnect',
          {#eventStream: _eventStream},
        ),
      );
    }
  }

  void addEvent(payloadMap) {
    final eventMap = payloadMap['data']['event'];
    final event = AppEvent.fromEventMap(eventMap);
    print(event);
    // final allData = {
    //   'user': {
    //     'stuff': {
    //       'name': event.id,
    //       'avatar': null,
    //       'type': 'user',
    //     },
    //   },
    // };

    // print(allData['user']);
    print('THIS IS THE EVENT TYPE ${event.type}');
    final allData = AppUserData.userDataTemp(event.type, event.id, null, 'user');

    final userdata = (allData
    as Map<dynamic, dynamic>? ??
        {})
        .map((key, value) => MapEntry(key, AppUserData.fromMap(value)))
        .cast<String, AppUserData>();

    // AppUserData.fromMap(AppEvent.getUser().data);
    _receiveAllEvents(
      receiveBuffer: [event],
      userdata: <String, AppUserData>{
        ..._eventStream.userData,
        ...userdata,
      },
      emit: () => _eventEmitter.emit(
        'event',
        {#event: event, #eventStream: _eventStream},
      ),
    );
  }

  void publishEvent(AppEvent event){
    final eventMap = {
      'type': event.type,
      'data': event.data,
    };
    final payloadMap = {
      'type': 'meya.orb.entry.ws.publish_request',
      'data': {
        'request_id': "test",
        'event': eventMap,
        'thread_id': "test",
      }
    };
    addEvent(payloadMap);

  }

  void _receiveAllEvents({
    required List<AppEvent> receiveBuffer,
    required Map<String, AppUserData> userdata,
    required void Function() emit
  }){
    print(receiveBuffer);
    print(userdata);
    print("This is whats going into userdata now ${userdata}");
    final newEventStream = EventStream(
      events: [...receiveBuffer, ..._eventStream.events],
      userData: <String, AppUserData>{..._eventStream.userData, ...userdata,}, );
    // <String, AppUserData>{..._eventStream.userData, ...userdata,},
    print("inside userData: ${_eventStream.userData['nativegpt.event.textMessage']}");
    print("This is userdata now ${_eventStream.userData}");

    if (newEventStream.events.length != _eventStream.events.length) {
      _eventStream = newEventStream;
      _eventEmitter.emit('eventStream', {#eventStream: _eventStream});
      emit();
    }
  }

}