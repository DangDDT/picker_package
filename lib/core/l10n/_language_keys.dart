// ignore_for_file: non_constant_identifier_names

import '../core_picker.dart';

class LanguageKeys {
  static String _tag(String key) => '${CorePicker.packageName}_$key';

  ///Words
  static String get gallery => _tag('gallery');

  static String get file => _tag('file');
  static String get file_s => _tag('file_s');

  static String get location => _tag('location');
  static String get location_s => _tag('location_s');

  static String get cancel => _tag('cancel');

  static String get select => _tag('select');

  static String get selected => _tag('selected');

  static String get unchecked => _tag('unchecked');

  static String get confirm => _tag('confirm');

  static String get sound => _tag('sound');

  static String get from => _tag('from');

  static String get image => _tag('image');
  static String get image_s => _tag('image_s');

  static String get quanlity => _tag('quanlity');

  static String get low => _tag('low');

  static String get medium => _tag('medium');

  static String get high => _tag('high');

  static String get veryHigh => _tag('very_high');

  static String get extremelyHigh => _tag('extremely_high');

  static String get maximum => _tag('maximum');

  static String get video => _tag('video');

  static String get yes => _tag('yes');

  static String get no => _tag('no');

  ///Sentences

  static String selectFromGalleryTitle = _tag('select_from_gallery_title');
  static String selectFromGallerySubtitle = _tag('select_from_gallery_subtitle');

  static String selectFromFileTitle = _tag('select_from_file_title');
  static String selectFromFileSubtitle = _tag('select_from_file_subtitle');

  static String selectFromSoundTitle = _tag('select_from_sound_title');
  static String selectFromSoundSubtitle = _tag('select_from_sound_subtitle');

  static String myLocation = _tag('my_location');

  /// Độ chính xác lên đến ... mét
  static String myLocationSubtitle = _tag('my_location_subtitle');

  static String defaultCaption = _tag('default_caption');

  static String confirmLocationDialogTitle = _tag('confirm_location_dialog_title');
  static String confirmCancelDialogTitle = _tag('confirm_cancel_dialog_title');
}
