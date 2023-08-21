import 'dart:collection';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/event_emitter.dart';


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
      final ud = AppEvent.getUser();
      print(ud);
      final userdata = (ud.data as Map<dynamic, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, AppUserData.fromMap(value)))
          .cast<String, AppUserData>();

      _receiveAllEvents(
        receiveBuffer: [AppEvent.connect()],
        userData: userdata,
        emit: () => _eventEmitter.emit(
          firstConnect ? 'firstConnect' : 'reconnect',
          {#eventStream: _eventStream},
        ),
      );
    }
  }

  void publishEvent(AppEvent event){
    final ud = AppEvent.getUser().data;
    final userdata = (ud["testing"] as Map<dynamic, dynamic>? ?? {})
        .map((key, value) => MapEntry(key, AppUserData.fromMap(value)))
        .cast<String, AppUserData>();
    print("userdata ${ud['name']}");
    print("userdata ${userdata}");

    // AppUserData.fromMap(AppEvent.getUser().data);
    _receiveAllEvents(
      receiveBuffer: [event],
      userData: userdata,
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