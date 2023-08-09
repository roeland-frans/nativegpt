
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
      throw Exception('Cannot create an OrbEvent with an empty \'type\'.');
    }
    return AppEvent(
      id: eventMap['id'],
      type: eventMap['type'],
      data: eventMap['data'],
    );
  }

  factory AppEvent.textMessage(String text, bool isCurrentUser) {
    return AppEvent(
      type: 'nativegpt.event.textMessage',
      data: {
        'text': text,
        'user': isCurrentUser
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


