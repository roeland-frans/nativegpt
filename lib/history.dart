import 'package:flutter/material.dart';

class Message {
  const Message({
    required this.text,
    required this.isCurrentUser,
  });
  final String text;
  final bool isCurrentUser;
}