import 'package:flutter/material.dart';
import 'package:testtextapp/ui/presence/user_avatar.dart';
import 'package:testtextapp/ui/theme.dart';

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
  final test?;

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

