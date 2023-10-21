import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:vif_previewer/previewer.dart';

class PreviewReturnValue {
  XFile? file;
  final Uint8List? bytes;
  final String? caption;
  final Duration? duration;
  MediaType mediaType;

  PreviewReturnValue({
    this.file,
    this.bytes,
    this.caption,
    this.duration,
    this.mediaType = MediaType.image,
  });

  set setFile(XFile? value) {
    file = value;
  }

  set setMediaType(MediaType value) {
    mediaType = value;
  }

  @override
  String toString() {
    return 'PreviewReturnValue(file: $file, bytes: $bytes, caption: $caption, duration: $duration, mediaType: $mediaType)';
  }
}
