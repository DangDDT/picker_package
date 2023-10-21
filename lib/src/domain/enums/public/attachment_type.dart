import 'package:core_picker/core/l10n/_language_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AttachmentType {
  media(
    icon: Icons.image,
  ),

  file(
    icon: Icons.insert_drive_file,
  ),
  location(
    icon: Icons.location_on,
  );

  const AttachmentType({required this.icon});

  final IconData icon;

  bool get isMedia => this == AttachmentType.media;

  bool get isFile => this == AttachmentType.file;

  bool get isLocation => this == AttachmentType.location;

  String get title {
    switch (this) {
      case AttachmentType.media:
        {
          return LanguageKeys.gallery.tr;
        }
      case AttachmentType.file:
        {
          return LanguageKeys.file.tr;
        }
      case AttachmentType.location:
        {
          return LanguageKeys.location.tr;
        }
    }
  }
}
