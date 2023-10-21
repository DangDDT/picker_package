import 'package:core_picker/core/core.dart';
import 'package:get/get.dart';

class DefaultPickerConstants {
  const DefaultPickerConstants._();

  static const String cancelText = 'Huỷ';

  static const String imageTitle = 'Hình ảnh';

  static const String videoTitle = 'Video';

  static const String audioTitle = 'Âm thanh';

  static const String fileTitle = 'Tệp';

  static const String locationTitle = 'Vị trí';

  static const String searchHint = 'Tìm kiếm';

  ///Default

  static String get defaultCaption => LanguageKeys.defaultCaption.tr;

  static String get defaultSubmitButtonTitle => LanguageKeys.confirm.tr;

  static const List<AttachmentType> categories = [
    AttachmentType.media,
    AttachmentType.file,
  ];

  static const int defaultMaxImagePerLoad = 100;

  static const int defaultImagePerRow = 3;
}
