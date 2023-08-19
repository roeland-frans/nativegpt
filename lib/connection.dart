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

  void addEvent(AppEvent event) {
    _receiveAllEvents(
      receiveBuffer: [event],
      emit: () => _eventEmitter.emit(
        'event',
        {#event: event, #eventStream: _eventStream},
      ),
    );
  }

  void connect() {
    if (firstConnect) {
      _receiveAllEvents(
        receiveBuffer: [],
        emit: () => _eventEmitter.emit(
          firstConnect ? 'firstConnect' : 'reconnect',
          {#eventStream: _eventStream},
        ),
      );
    }
  }

  void _receiveAllEvents({required List<AppEvent> receiveBuffer, required void Function() emit}){
    final newEventStream = EventStream(events: [...receiveBuffer, ..._eventStream.events],);
    if (newEventStream.events.length != _eventStream.events.length) {
      _eventStream = newEventStream;
      _eventEmitter.emit('eventStream', {#eventStream: _eventStream});
      emit();
    }
  }

}