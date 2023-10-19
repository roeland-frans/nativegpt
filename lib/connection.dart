import 'package:testtextapp/event.dart';
import 'package:testtextapp/app.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/storage.dart';
import 'package:testtextapp/event_emitter.dart';
import 'package:testtextapp/ui/card/avatar.dart';
import 'package:testtextapp/actordata.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';


class AppConnection {
  final EventEmitter _eventEmitter = EventEmitter();
  EventStream _eventStream = EventStream();
  final MyAppState appState;
  final ActorData actorData;

  AppConnection({required this.actorData, required this.appState});

  bool firstConnect = true;

  void addOrbListener(String type, Function listener) =>
      _eventEmitter.on(type, listener);

  void removeOrbListener(String type, Function listener) =>
      _eventEmitter.off(type, listener);

  void connect() {
    if (firstConnect) {
      AppEvent event = AppEvent.connect(ActorData.sysId);
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
    final userData = actorData.userList()[event.id];
    final avatarData = AppAvatar(image: appState.getAvatar(event.id!), crop: AppAvatarCrop.circle, monogram: appState.getName(event.id!)[0]);
    print("yes");
    final allData = AppUserData.userDataTemp(event.id, appState.getName(event.id!), avatarData, userData!['type']);

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
  final ActorData actorData;

  BotConnection({required this.connection, required this.dataStore, required this.actorData, });

  // final botId = actorData.userList()[ActorData.botId]!;
  OpenAI openai = OpenAI(apiKey: "None");
  final memory = ConversationBufferMemory(returnMessages: true);
  late ConversationChain conversation;
  // late LLMChain chain;
  // final history = ChatMessageHistory();

  Future<void> connect() async {
    await dataStore.readItem("apiKey");
    openai = OpenAI(apiKey: dataStore.apikey);
    final memory = ConversationBufferMemory(returnMessages: true);
    // final botPrompt = SystemChatMessagePromptTemplate.fromTemplate("hi");
    // final humanPrompt = HumanChatMessagePromptTemplate.fromTemplate('{text}');
    // final chatPrompt = ChatPromptTemplate.fromPromptMessages([botPrompt,humanPrompt]);
    // chain = LLMChain(llm: openai, prompt: chatPrompt);
    conversation = ConversationChain(
      llm: openai,
      memory: memory,
    );
    // final result = await conversation.run('Hello');
    // print(result);
  }
  // , model: 'gpt-3.5-turbo'

  void updateBot(String? model, String? apiKey) {
    openai = OpenAI(apiKey: apiKey ?? dataStore.apikey, model: 'gpt-3.5-turbo');
    if (apiKey != null) {
      dataStore.deleteItem("apiKey");
      dataStore.addItem("apiKey", apiKey);
    }
  }

  void updateKey(String apiKey) {
    openai = OpenAI(apiKey: apiKey, model: 'gpt-3.5-turbo');
    dataStore.deleteItem("apiKey");
    dataStore.addItem("apiKey", apiKey);
  }

  Future<void> getBot(AppEvent event) async {
    final text = HumanChatMessage(content: event.data['text']);
    final result = await conversation.run([text]);
    print(result);
    // final result = await openai.predictMessages([text]);
    connection.publishEvent(AppEvent.textMessage(result, ActorData.botId),);
  }
}

