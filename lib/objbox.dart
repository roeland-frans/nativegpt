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

  String? name;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime? date;

  @Transient() // Ignore this property, not stored in the database.
  int? computedProperty;
}

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    final userBox = store.box<Setting>();
    final test1 = Setting();
    userBox.put(test1);


    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}

class testObjBox {

}
