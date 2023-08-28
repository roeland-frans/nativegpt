import 'dart:collection';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/event_emitter.dart';
import 'package:testtextapp/ui/card/avatar.dart';
import 'package:testtextapp/actordata.dart';


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
      final allData = AppUserData.userDataTemp('user00', 'System', null, 'system');
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
          firstConnect ? 'connected' : 'reconnect',
          {#eventStream: _eventStream},
        ),
      );
    }
  }

  void publishEvent(AppEvent event){
    final actorData = ActorData.userList()[event.id];
    final avatarData = AppAvatar(image: actorData?['image'], crop: AppAvatarCrop.circle, monogram: actorData!['name']![0]);
    final allData = AppUserData.userDataTemp(event.id, actorData['name'], avatarData, actorData['type']);

    final userdata = (allData
    as Map<dynamic, dynamic>? ??
        {})
        .map((key, value) => MapEntry(key, AppUserData.fromMap(value)))
        .cast<String, AppUserData>();

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

  void _receiveAllEvents({
    required List<AppEvent> receiveBuffer,
    required Map<String, AppUserData> userdata,
    required void Function() emit
  }){
    final newEventStream = EventStream(
      events: [...receiveBuffer, ..._eventStream.events],
      userData: <String, AppUserData>{..._eventStream.userData, ...userdata,}, );

    if (newEventStream.events.length != _eventStream.events.length) {
      _eventStream = newEventStream;
      _eventEmitter.emit('eventStream', {#eventStream: _eventStream});
      emit();
    }
  }

}