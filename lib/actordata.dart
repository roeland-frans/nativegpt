
import 'app.dart';

class ActorData {
  static String sysId = 'user00';
  static String userId = 'user01';
  static String botId = 'user02';

  // final MyAppState appState;
  // ActorData({required this.appState});

  Map<String, Map<String, String?>> userList() => {
    sysId: {
      'name': 'System',
      'type': 'system',
    },
    userId: {
      'name': 'Guest',
      'type': 'user',
      'image': null,
    },
    botId: {
      'name': 'Chatbot',
      'type': 'bot',
      'image': null,
    },
  };

}