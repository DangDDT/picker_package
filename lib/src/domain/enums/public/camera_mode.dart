import 'package:get/get.dart';

import '../../../../core/core.dart';

enum CameraMode {
  video,
  photo;

  const CameraMode();

  get isPhoto => this == photo;
  get isVideo => this == video;

  get title {
    switch (this) {
      case photo:
        return LanguageKeys.image.tr;
      case video:
        return LanguageKeys.video.tr;
    }
  }
}
