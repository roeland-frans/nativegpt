import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';


class DataStore {

  final _storage = const FlutterSecureStorage();
  String? apikey = "None";

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
    if (key == "apiKey") {
      apikey = value;
    }
  }

  Future<void> readItem(String key) async {
    final result = await _storage.read(key: key);
    print(result);
    if (key == "apiKey") {
      apikey = result ?? "None";
    }
  }

}

