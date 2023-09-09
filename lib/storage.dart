import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testtextapp/actordata.dart';

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class DataStore {

  final _storage = const FlutterSecureStorage();
  String? apikey = "placeholder";

  void deleteItem(String key) async {
    await _storage.delete(
      key: key,
    );
  }

  void addItem(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
    );
  }


  Future<void> readItem(String key) async {
    final result = await _storage.read(key: key);
    // print("found");
    apikey = result;
    // print(result);
    // print(apikey);
    // print("got");
    // apiEvent = AppEvent.getSecureStore(result, key, ActorData.sysID);
  }


  // String? performAction(String action, String key, String value, BuildContext context,)  {
  //   if (action == 'delete') {
  //     _storage.delete(
  //       key: key,
  //     );
  //   } else if (action == 'add'){
  //     _storage.delete(
  //       key: key,
  //     );
  //   } else if (action == 'read') {
  //     final result = _storage.read(key: key);
  //     return result;
  //   }
  //   return null;
  // }
}

