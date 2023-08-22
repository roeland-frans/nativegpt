import 'dart:collection';

import 'package:testtextapp/event.dart';
import 'package:flutter/material.dart';
import 'package:testtextapp/ui/card/avatar.dart';

class EventStream extends ChangeNotifier{
  final List<AppEvent> events;
  final Map<String, AppUserData> userData;

  EventStream._({required this.events, required this.userData,});

  factory EventStream({List<AppEvent> events = const [], Map<String, AppUserData> userData = const {},}){
    final eventStream = EventStream._(events: events, userData: userData);
    return eventStream;
  }

}

enum UserType { bot, user }

extension UserTypeExtension on UserType {
  static UserType fromString(String? type) =>
      {
        'bot': UserType.bot,
        'user': UserType.user,
      }[type!] ??
          UserType.bot;
}

class AppUserData {
  final String? name;
  final AppAvatar? avatar;
  final UserType type;

  AppUserData({
    required this.name,
    required this.avatar,
    required this.type,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'avatar': avatar,
    'type': type,
  };

  Map<String, dynamic> getMap(userID) {
    Map<String, dynamic> userdata = HashMap();
    userdata.addAll({'name': 'test'});

    return userdata;
  }

  factory AppUserData.fromMap(Map<dynamic, dynamic> map) {
    return AppUserData(
      name: map['name'],
      avatar: map['avatar'],
      type: UserTypeExtension.fromString(map['type']),
    );
  }
}