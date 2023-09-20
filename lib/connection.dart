import 'dart:collection';
import 'dart:io';
import 'package:testtextapp/event.dart';
import 'package:testtextapp/app.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/storage.dart';
import 'package:testtextapp/event_emitter.dart';
import 'package:testtextapp/ui/card/avatar.dart';
import 'package:testtextapp/actordata.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:testtextapp/ui/settings.dart';



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
      AppEvent event = AppEvent.connect(ActorData.sysID);
      final allData = AppUserData.userDataTemp(event.id, 'System', null, 'system');
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
          'connect',
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

class BotConnection {

  final AppConnection connection;
  final DataStore dataStore;

  final botId = ActorData.userList()[ActorData.botID]!;
  ChatOpenAI openai = ChatOpenAI(apiKey: "None");

  BotConnection({required this.connection, required this.dataStore});

  Future<void> connect(String apiKey) async {
    await dataStore.readItem("apiKey");
    openai = ChatOpenAI(apiKey: dataStore.apikey, model: 'gpt-3.5-turbo');
  }

  void updateBot(String? model, String? apiKey) {
    openai = ChatOpenAI(apiKey: apiKey ?? dataStore.apikey, model: 'gpt-3.5-turbo');
    if (apiKey != null) {
      dataStore.deleteItem("apiKey");
      dataStore.addItem("apiKey", apiKey);
    }
  }

  void updateKey(String apiKey) {
    openai = ChatOpenAI(apiKey: apiKey, model: 'gpt-3.5-turbo');
    dataStore.deleteItem("apiKey");
    dataStore.addItem("apiKey", apiKey);
  }

  Future<void> getBot(AppEvent event) async {
    final text = HumanChatMessage(content: event.data['text']);
    final result = await openai.predictMessages([text]);
    connection.publishEvent(AppEvent.textMessage(result.content, ActorData.botID),);
  }
}

