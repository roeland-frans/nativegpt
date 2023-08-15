import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget{
  const AppAvatar({
    required this.isCurrentUser,
  });
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    if (isCurrentUser){
      return Icon(Icons.person);
    } else {
      return Icon(Icons.android);
    }
  }

}