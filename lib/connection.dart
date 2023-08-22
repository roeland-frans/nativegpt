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
      _receiveAllEvents(
        receiveBuffer: [AppEvent.connect()],
        userData: {},
        emit: () => _eventEmitter.emit(
          firstConnect ? 'firstConnect' : 'reconnect',
          {#eventStream: _eventStream},
        ),
      );
    }
  }

  void publishEvent(AppEvent event){
    final eventMap = {
      'type': event.type,
      'data': event.data,
    };
    final Map<dynamic, dynamic> allData = {
      'user': {
        'name': event.id,
        'avatar': AppAvatar,
        'type': UserType.user,
      },
      'bot': {
        'name': event.id,
        'avatar': AppAvatar,
        'type': UserType.user,
      }
    };
    Map<String, dynamic> userData() => {
      'name': event.id,
      'avatar': AppAvatar,
      'type': UserType.user,
    };
    final userID = event.id;
    final userdata = (allData['user']
    as Map<dynamic, dynamic>? ??
        {})
        .map((key, value) => MapEntry(key, AppUserData.fromMap(value)))
        .cast<String, AppUserData>();
    print("DONE");

    // AppUserData.fromMap(AppEvent.getUser().data);
    _receiveAllEvents(
      receiveBuffer: [AppEvent.fromEventMap(eventMap)],
      userData: <String, AppUserData>{
        ..._eventStream.userData,
        ...userdata,
      },
      emit: () => _eventEmitter.emit(
        'event',
        {#event: event, #eventStream: _eventStream},
      ),
    );
  }

  void _receiveAllEvents({
    required List<AppEvent> receiveBuffer,
    required Map<String, AppUserData> userData,
    required void Function() emit
  }){
    print(receiveBuffer);
    print(userData);
    final newEventStream = EventStream(
      events: [...receiveBuffer, ..._eventStream.events],
      userData: <String, AppUserData>{..._eventStream.userData, ...userData,}, );
    if (newEventStream.events.length != _eventStream.events.length) {
      _eventStream = newEventStream;
      _eventEmitter.emit('eventStream', {#eventStream: _eventStream});
      emit();
    }
  }

}