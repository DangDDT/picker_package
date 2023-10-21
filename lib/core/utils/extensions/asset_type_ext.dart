import 'package:photo_manager/photo_manager.dart';
import 'package:vif_previewer/previewer.dart';

extension AssetTypeExt on AssetType {
  MediaType get mediaType {
    switch (this) {
      case AssetType.image:
        return MediaType.image;
      case AssetType.video:
        return MediaType.video;
      default:
        return MediaType.image;
    }
  }
}
