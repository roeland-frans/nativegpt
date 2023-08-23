
class AppEvent implements Comparable<AppEvent>{
  String? id;
  String type;
  Map<dynamic, dynamic> data;

  AppEvent({required this.type, required this.data, this.id});

  @override
  String toString() {
    return 'Event($id, $type, $data)';
  }

  Map<String, dynamic> toEventMap() => {
    'id': id,
    'type': type,
    'data': data,
  };

  factory AppEvent.fromEventMap(Map<dynamic, dynamic> eventMap) {
    if (eventMap['type'] == null) {
      throw Exception('Cannot create an AppEvent with an empty \'type\'.');
    }
    return AppEvent(
      id: eventMap['id'],
      type: eventMap['type'],
      data: eventMap['data'],
    );
  }

  factory AppEvent.connect() {
    return AppEvent(
      type: 'nativegpt.event.connect',
      data: {
        'userid': "testUser"
      }
    );
  }

  factory AppEvent.textMessage(String text, String userID) {
    return AppEvent(
      id: userID,
      type: 'nativegpt.event.textMessage',
      data: {
        'text': text,
      }
    );
  }

  bool checkSender(word) {
    if (word[0] == "t") {
      return true;
    } else {
      return false;
    }
  }

  @override
  int compareTo(AppEvent other) {
    // TODO: implement compareTo
    throw UnimplementedError();
  }

}


