// // ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core_picker/src/domain/enums/public/file_picker_type.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../src/domain/enums/public/attachment_type.dart';

class ModuleConfig {
  ModuleConfig({
    this.submitButtonTitle,
    required this.submitButtonIcon,
    required this.isShowLog,
    required this.categories,
    this.mediaPickerOption,
    this.locationPickerOption,
    this.filePickerOption,
  });

  final bool isShowLog;
  final String? submitButtonTitle;
  final IconData submitButtonIcon;
  final List<AttachmentType> categories;
  final MediaPickerOption? mediaPickerOption;
  final LocationPickerOption? locationPickerOption;
  final FilePickerOption? filePickerOption;
}

enum MediaPickerType {
  image,
  video;

  isImage() => this == MediaPickerType.image;
  isVideo() => this == MediaPickerType.video;
}

extension ListMediaPickerTypeExtension on List<MediaPickerType> {
  bool get isOnlyImage => length == 1 && first.isImage();

  bool get isOnlyVideo => length == 1 && first.isVideo();

  bool get isImageAndVideo => length == 2;

  RequestType get mapToPhotoManagerRequestType {
    if (isOnlyImage) {
      return RequestType.image;
    } else if (isOnlyVideo) {
      return RequestType.video;
    } else {
      return RequestType.common;
    }
  }
}

class MediaPickerOption {
  MediaPickerOption({
    this.maxMediaPerLoadTime = 100,
    this.mediaPerRow = 3,
    this.isUseCamera = true,
    this.isUseCameraInsideAlbum = true,
    this.isShowPreviewInfo = false,
    this.isUseCaptionField = true,
    this.captionFieldConfig = const CaptionFieldConfig(
      maxCaptionLength: 100,
    ),
    this.mediaPickerTypes = const [
      MediaPickerType.image,
      MediaPickerType.video
    ],
    this.isMultiSelection = true,
  })  : assert(maxMediaPerLoadTime > 0 && mediaPerRow > 0),
        assert(mediaPerRow <= 5),
        assert(mediaPickerTypes.isNotEmpty);

  int maxMediaPerLoadTime;
  final int mediaPerRow;
  final bool isUseCamera;
  final bool isUseCameraInsideAlbum;
  final bool isShowPreviewInfo;
  final bool isUseCaptionField;
  final CaptionFieldConfig captionFieldConfig;
  final List<MediaPickerType> mediaPickerTypes;
  final bool isMultiSelection;
}

class LocationPickerOption {
  const LocationPickerOption({
    this.isUseCaptionField = true,
    this.captionFieldConfig = const CaptionFieldConfig(
      maxCaptionLength: 100,
    ),
  });

  final bool isUseCaptionField;
  final CaptionFieldConfig captionFieldConfig;
}

class FilePickerOption {
  const FilePickerOption({
    this.isUseCaptionField = true,
    this.selectMultipleFiles = false,
    this.captionFieldConfig = const CaptionFieldConfig(
      maxCaptionLength: 100,
    ),
    this.allowedExtensionsForFileCustomPicker = const [
      'pdf',
      'doc',
      'docx',
      'xls',
      'xlsx',
      'ppt',
      'pptx',
      'txt',
      'zip',
      'rar',
      '7z',
      'jpg',
      'jpeg',
      'png',
      'gif',
      'mp4',
      'avi',
      'mov',
      'wmv',
      'flv',
      'mp3',
      'wav',
      'wma',
      'ogg',
      'aac',
      'm4a',
      'flac',
      'webm',
      'mkv'
    ],
    this.filePickerTypes = FilePickerType.values,
  });

  final bool isUseCaptionField;
  final CaptionFieldConfig captionFieldConfig;
  final List<String>? allowedExtensionsForFileCustomPicker;
  final List<FilePickerType>? filePickerTypes;
  final bool selectMultipleFiles;
}

class CaptionFieldConfig {
  const CaptionFieldConfig({
    required this.maxCaptionLength,
    this.captionHint,
  });

  final int maxCaptionLength;
  final String? captionHint;
}
