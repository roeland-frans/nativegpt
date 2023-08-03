import 'package:testtextapp/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppEvent {
  void writeTo(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/testlog.txt');
    await file.writeAsString("$text\n", mode: FileMode.append);
  }

  bool checkSender(word) {
    if (word[0] == "t") {
      return true;
    } else {
      return false;
    }
  }

}

class Message {
  const Message({
    required this.text,
    required this.isCurrentUser,
  });
  final String text;
  final bool isCurrentUser;
}