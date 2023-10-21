// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:vif_previewer/previewer.dart';

abstract class AttachmentData extends Equatable {}

class MediaAttachmentData extends AttachmentData {
  MediaAttachmentData(
    this.image,
    this.file,
    this.mediaType,
  );
  final Uint8List? image;
  final File? file;
  final MediaType? mediaType;

  @override
  List<Object?> get props => [image, file, mediaType];

  @override
  String toString() => 'ImageAttachmentData(path: $file)';
}

class AudioAttachmentData extends AttachmentData {
  AudioAttachmentData(
    this.path,
  );
  final String? path;

  @override
  List<Object?> get props => [path];

  @override
  String toString() => 'AudioAttachmentData(path: $path)';
}

class FileAttachmentData extends AttachmentData {
  FileAttachmentData(
    this.path,
    this.file,
    this.name,
    this.extensionString,
    this.size,
  );
  final File? file;
  final String? path;
  final String? name;
  final String? extensionString;
  final int? size;

  @override
  List<Object?> get props => [path, file, name, extensionString, size];

  @override
  String toString() =>
      'FileAttachmentData(path: $path, file: $file, name: $name, extensionString: $extensionString, size: $size)';
}

class LocationAttachmentData extends AttachmentData {
  LocationAttachmentData(
    this.latitude,
    this.longitude,
    this.tag,
  );
  final double? latitude;
  final double? longitude;
  final String tag;

  @override
  List<Object?> get props => [latitude, longitude, tag];

  @override
  String toString() => 'LocationAttachmentData(latitude: $latitude, longitude: $longitude, tag: $tag)';
}
