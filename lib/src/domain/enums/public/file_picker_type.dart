import 'package:file_picker/file_picker.dart';

enum FilePickerType {
  media,
  custom,
  audio,
}

extension FilePickerTypeExtension on FilePickerType {
  FileType get fileType {
    switch (this) {
      case FilePickerType.media:
        return FileType.media;
      case FilePickerType.audio:
        return FileType.audio;
      case FilePickerType.custom:
        return FileType.custom;
      default:
        return FileType.custom;
    }
  }
}
