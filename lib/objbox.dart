import 'dart:io';

import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

@Entity()
class Setting {
  @Id()
  int id = 0;

  @Index()
  String settingtype = "";

  String? name;
  String? actorid;

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
    _query = _box.query().order(Setting_.settingtype, flags: Order.descending).build();
  }

  void addSetting(String name, String uid, String actorId) {
    final setting = Setting();
    setting.name = name;
    setting.settingtype = uid;
    setting.actorid = actorId;
    removeSetting(uid);
    _box.put(setting);
  }

  List<Setting> getAllSettingQuery() {
    List<Setting> allQuery = _query.find();
    return allQuery;
  }

  List<Setting> getSettingQuery(String uid, String actorId) {
    Query<Setting> query = _box.query(Setting_.settingtype.equals(uid).and(Setting_.actorid.equals(actorId))).build();
    List<Setting> settingQuery = query.find();
    // print(settingQuery);
    query.close();
    return settingQuery;
  }

  void removeSetting(String uid) {
    Query<Setting> query = _box.query(Setting_.settingtype.equals(uid)).build();
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
