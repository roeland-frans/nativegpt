class ActorData {
  static String sysID = 'user00';
  static String userID = 'user01';
  static String botID = 'user02';

  static String userName = 'TestName';
  static Map<String, Map<String, String?>> userList() => {
    sysID: {
      'name': 'System',
      'type': 'system',
    },
    userID: {
      'name': 'Guest',
      'type': 'user',
      'image': 'https://picsum.photos/250?image=9',
    },
    botID: {
      'name': 'Chatbot',
      'type': 'bot',
      'image': null,
    },
  };

}