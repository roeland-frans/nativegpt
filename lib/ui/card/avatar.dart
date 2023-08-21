import 'package:flutter/material.dart';
import 'package:testtextapp/ui/presence/user_avatar.dart';

class AppAvatar {
  final UserAvatar userAvatar;
  final bool? isCurrentUser;

  const AppAvatar({
    required this.isCurrentUser,
    required this.userAvatar,
  });



  static AppAvatar? fromMap(Map<dynamic, dynamic>? map){
    if (map == null) {
      return null;
    }
    return AppAvatar(isCurrentUser: map['isUser'], userAvatar: map['image']);
  }




}