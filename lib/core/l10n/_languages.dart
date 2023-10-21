// ignore_for_file: non_constant_identifier_names

import '_language_keys.dart';

abstract class Languages {
  ///Words
  String get gallery;

  String get file;
  String get file_s;

  String get location;
  String get location_s;

  String get cancel;

  String get select;

  String get selected;

  String get confirm;

  String get unchecked;

  String get from;

  String get sound;

  String get image;
  String get image_s;

  String get quality;

  String get low;

  String get medium;

  String get high;

  String get veryHigh;

  String get extremelyHigh;

  String get maximum;

  String get video;

  String get yes;

  String get no;

  ///Sentences
  String get selectFromGalleryTitle;
  String get selectFromGallerySubtitle;

  String get selectFromFileTitle;
  String get selectFromFileSubtitle;

  String get selectFromSoundTitle;
  String get selectFromSoundSubtitle;

  String get myLocation;
  String get myLocationSubtitle;

  String get defaultCaption;

  String get confirmLocationDialogTitle;
  String get confirmCancelDialogTitle;

  Map<String, String> get message => {
        ///Words
        LanguageKeys.gallery: gallery,
        LanguageKeys.file: file,
        LanguageKeys.file_s: file_s,
        LanguageKeys.location: location,
        LanguageKeys.location_s: location_s,
        LanguageKeys.cancel: cancel,
        LanguageKeys.select: select,
        LanguageKeys.sound: sound,
        LanguageKeys.from: from,
        LanguageKeys.selected: selected,
        LanguageKeys.unchecked: unchecked,
        LanguageKeys.confirm: confirm,
        LanguageKeys.image: image,
        LanguageKeys.image_s: image_s,
        LanguageKeys.quanlity: quality,
        LanguageKeys.low: low,
        LanguageKeys.medium: medium,
        LanguageKeys.high: high,
        LanguageKeys.veryHigh: veryHigh,
        LanguageKeys.extremelyHigh: extremelyHigh,
        LanguageKeys.maximum: maximum,
        LanguageKeys.video: video,
        LanguageKeys.yes: yes,
        LanguageKeys.no: no,

        ///Sentences
        LanguageKeys.selectFromGalleryTitle: selectFromGalleryTitle,
        LanguageKeys.selectFromGallerySubtitle: selectFromGallerySubtitle,

        LanguageKeys.selectFromFileTitle: selectFromFileTitle,
        LanguageKeys.selectFromFileSubtitle: selectFromFileSubtitle,

        LanguageKeys.selectFromSoundTitle: selectFromSoundTitle,
        LanguageKeys.selectFromSoundSubtitle: selectFromSoundSubtitle,

        LanguageKeys.myLocation: myLocation,
        LanguageKeys.myLocationSubtitle: myLocationSubtitle,

        LanguageKeys.defaultCaption: defaultCaption,

        LanguageKeys.confirmLocationDialogTitle: confirmLocationDialogTitle,
        LanguageKeys.confirmCancelDialogTitle: confirmCancelDialogTitle,
      };
}
