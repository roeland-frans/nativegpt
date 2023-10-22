
class AppEvent implements Comparable<AppEvent>{
  String? id;
  String type;
  Map<dynamic, dynamic> data;

  AppEvent({required this.type, required this.data, this.id});

  @override
  String toString() {
    return 'Event($id, $type, $data)';
  }

  Map<String, dynamic> toEventMap() => {
    'id': id,
    'type': type,
    'data': data,
  };

  factory AppEvent.fromEventMap(Map<dynamic, dynamic> eventMap) {
    if (eventMap['type'] == null) {
      throw Exception('Cannot create an AppEvent with an empty \'type\'.');
    }
    return AppEvent(
      id: eventMap['id'],
      type: eventMap['type'],
      data: eventMap['data'],
    );
  }

  factory AppEvent.connect(String systemID) {
    return AppEvent(
      id: systemID,
      type: 'nativegpt.event.connect',
      data: {
        'userid': "testUser"
      }
    );
  }

  factory AppEvent.textMessage(String text, String senderID) {
    return AppEvent(
      id: senderID,
      type: 'nativegpt.event.textMessage',
      data: {
        'text': text,
      }
    );
  }

  @override
  int compareTo(AppEvent other) {
    // TODO: implement compareTo
    throw UnimplementedError();
  }
}

// enum AppComposerFocus { file, image, text, blur }
//
// extension AppComposerFocusExtension on AppComposerFocus {
//   static AppComposerFocus? fromString(String? focus) {
//     switch (focus) {
//       case 'file':
//         return AppComposerFocus.file;
//       case 'image':
//         return AppComposerFocus.image;
//       case 'blur':
//         return AppComposerFocus.blur;
//       case 'text':
//         return AppComposerFocus.text;
//       default:
//         return null;
//     }
//   }
// }
//
// enum AppComposerVisibility { collapse, hide, show }
//
// extension AppComposerVisibilityExtension on AppComposerVisibility {
//   static AppComposerVisibility? fromString(String? visibility) {
//     switch (visibility) {
//       case 'collapse':
//         return AppComposerVisibility.collapse;
//       case 'hide':
//         return AppComposerVisibility.hide;
//       case 'show':
//         return AppComposerVisibility.show;
//       default:
//         return null;
//     }
//   }
// }
//
// class AppComposerEventSpec {
//   final AppComposerFocus? focus;
//   final String? placeholder;
//   final String? collapsePlaceholder;
//   final AppComposerVisibility? visibility;
//
//   const AppComposerEventSpec({
//     this.focus,
//     this.placeholder,
//     this.collapsePlaceholder,
//     this.visibility,
//   });
//
//   static AppComposerEventSpec? fromMap(Map<dynamic, dynamic>? map) {
//     if (map == null) {
//       return null;
//     }
//     return AppComposerEventSpec(
//       focus: AppComposerFocusExtension.fromString(map['focus']),
//       placeholder: map['placeholder'],
//       collapsePlaceholder: map['collapsePlaceholder'],
//       visibility: AppComposerVisibilityExtension.fromString(map['visibility']),
//     );
//   }
// }



