
enum AppAvatarCrop { circle, square }

extension AppAvatarCropExtension on AppAvatarCrop {
  static AppAvatarCrop fromString(String? crop) {
    switch (crop) {
      case 'square':
        return AppAvatarCrop.square;
      default:
        return AppAvatarCrop.circle;
    }
  }
}

class AppAvatar {
  final String? image;
  final AppAvatarCrop crop;
  final String? monogram;

  const AppAvatar({
    required this.image,
    required this.crop,
    required this.monogram,
  });

  static AppAvatar? fromMap(Map<dynamic, dynamic>? map){
    if (map == null) {
      return null;
    }
    return AppAvatar(
      image: map['image'],
      crop: AppAvatarCropExtension.fromString(map['crop']),
      monogram: map['monogram'],
    );
  }
}

