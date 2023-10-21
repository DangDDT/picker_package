// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../enums/public/attachment_type.dart';
import 'attachment_data.dart';

class AttachmentResult extends Equatable {
  const AttachmentResult({
    required this.type,
    required this.data,
    this.selectedTime,
    this.caption,
    this.itemCount = 0,
  });
  final AttachmentType type;
  final List<AttachmentData> data;
  final String? caption;
  final int itemCount;
  final DateTime? selectedTime;

  @override
  List<Object?> get props => [type, data, caption, itemCount, selectedTime];

  @override
  bool get stringify => true;
}

extension AttachmentResultX on AttachmentResult {
  bool get isImage => type.isMedia;

  bool get isFile => type.isFile;

  bool get isLocation => type.isLocation;

  List<MediaAttachmentData> getImageAttachmentData() {
    final List<MediaAttachmentData> data = [];
    if (isImage) {
      for (final AttachmentData item in this.data) {
        data.add(item as MediaAttachmentData);
      }
      return data;
    }
    return [];
  }

  List<FileAttachmentData> getFileAttachmentData() {
    if (isFile) {
      final List<FileAttachmentData> data = [];
      for (final AttachmentData item in this.data) {
        data.add(item as FileAttachmentData);
      }
      return data;
    }
    return [];
  }

  List<LocationAttachmentData> getLocationAttachmentData() {
    if (isLocation) {
      final List<LocationAttachmentData> data = [];
      for (final AttachmentData item in this.data) {
        data.add(item as LocationAttachmentData);
      }
      return data;
    }
    return [];
  }
}
