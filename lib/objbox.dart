import 'dart:io';

import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

// @Entity()
// class User {
//   @Id()
//   int id = 0;
//
//   String? name;
//
//   @Property(type: PropertyType.date) // Store as int in milliseconds
//   DateTime? date;
//
//   @Transient() // Ignore this property, not stored in the database.
//   int? computedProperty;
// }

@Entity()
class Setting {
  @Id()
  int id = 0;

  @Index()
  String uid = "";

  String? name;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime? date;

  @Transient() // Ignore this property, not stored in the database.
  int? computedProperty;
}

class ObjectBox {
  /// The Store of this app.
  final Store store;
  // late final ObjControl objControl = ObjControl();
  late final Box<Setting> _box;
  late final Query<Setting> _query;


  ObjectBox._create(this.store) {
    _box = store.box<Setting>();
    _query = _box.query().order(Setting_.uid, flags: Order.descending).build();
  }

  void addSetting(String name, String uid) {
    final setting = Setting();
    setting.name = name;
    setting.uid = uid;
    removeSetting(uid);
    _box.put(setting);
  }

  List<Setting> getAllSetting() {
    List<Setting> allQuery = _query.find();
    return allQuery;
  }

  List<Setting> getSetting(String uid) {
    Query<Setting> query = _box.query(Setting_.uid.equals(uid)).build();
    List<Setting> settingQuery = query.find();
    // print(settingQuery);
    // for (int i = 0; i < settingQuery.length; i ++) {
    //   print(settingQuery[i].id);
    // }
    query.close();
    return settingQuery;
  }

  void removeSetting(String uid) {
    Query<Setting> query = _box.query(Setting_.uid.equals(uid)).build();
    query.remove();
    query.close();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}
