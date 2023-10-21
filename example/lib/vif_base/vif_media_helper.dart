import 'dart:async';
import 'dart:developer';

// import 'package:core_camera/camera/model/camera_model.dart';
// import 'package:core_camera/core_camera.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_filex/open_filex.dart';

import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFMediaHelper extends VIFMediaHelperDataSource {
  // @override
  // FutureOr<VIFFileMediaData?> chooseFile() async {
  //   try {
  //     final pickFileResult = await FilePicker.platform.pickFiles();
  //     if (pickFileResult != null) {
  //       final file = pickFileResult.files.first;
  //       return VIFFileMediaData(
  //         file.path ?? '',
  //         file.name,
  //         MediaFileType.file,
  //         dataFile: file.bytes,
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log(e.toString(), stackTrace: stackTrace, name: 'PICK_FILE_EXCEPTION');
  //   }
  //   return null;
  // }
  //
  // @override
  // FutureOr<VIFFileMediaData?> pickImage() async {
  //   try {
  //     final file = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //     );
  //     if (file != null) {
  //       return VIFFileMediaData(
  //         file.path,
  //         file.name,
  //         MediaFileType.image,
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log(e.toString(), name: 'PICK_IMAGE_EXCEPTION', stackTrace: stackTrace);
  //   }
  //   return null;
  // }
  //
  // @override
  // FutureOr<VIFFileMediaData?> recordVideo() async {
  //   try {
  //     final file = await ImagePicker().pickVideo(
  //       source: ImageSource.camera,
  //     );
  //     if (file != null) {
  //       return VIFFileMediaData(
  //         file.path,
  //         file.name,
  //         MediaFileType.video,
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log(e.toString(), name: 'RECORD_VIDEO_EXCEPTION', stackTrace: stackTrace);
  //   }
  //   return null;
  // }
  //
  // @override
  // FutureOr<VIFFileMediaData?> takePicture() async {
  //   try {
  //     final file = await ImagePicker().pickImage(
  //       source: ImageSource.camera,
  //     );
  //
  //     if (file != null) {
  //       return VIFFileMediaData(
  //         file.path,
  //         file.name,
  //         MediaFileType.video,
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log(e.toString(), name: 'TAKE_PICTURE_EXCEPTION', stackTrace: stackTrace);
  //   }
  //   return null;
  // }

  @override
  FutureOr<Iterable<VIFFileMediaData>?> goAlbums(
    BuildContext context,
  ) async {
    Iterable<VIFFileMediaData>? result;
    try {
      // final file = await ImagePicker().pickImage(
      //   source: ImageSource.gallery,
      // );
      // if (file != null) {
      //   result = [VIFFileMediaData(file.path, file.name)];
      // }
    } catch (e, stackTrace) {
      log(e.toString(), name: 'PICK_IMAGE_EXCEPTION', stackTrace: stackTrace);
    }
    return result;
  }

  @override
  FutureOr<VIFFileMediaData?> goAlbum(
    BuildContext context,
  ) async {
    VIFFileMediaData? result;
    try {
      // final file = await ImagePicker().pickImage(
      //   source: ImageSource.gallery,
      // );
      // if (file != null) {
      //   result = VIFFileMediaData(file.path, file.name);
      // }
    } catch (e, stackTrace) {
      log(e.toString(), name: 'PICK_IMAGE_EXCEPTION', stackTrace: stackTrace);
    }
    return result;
  }

  @override
  FutureOr<VIFFileMediaData?> goCamera(
    BuildContext context, {
    VIFMediaType mediaType = VIFMediaType.both,
  }) async {
    try {
      // CameraModel? result;
      // await Navigator.of(context).push<CameraModel>(
      //   MaterialPageRoute(
      //     builder: (ctx) => CameraScreen(
      //       saveMedia: false,
      //       speciesCamera: 1,
      //       timeOutVideoCamera: 5,
      //       ghiChu: true,
      //       onResult: (CameraModel cameraModel) => result = cameraModel,
      //     ),
      //   ),
      // );
      // if (result != null) {
      //   return VIFFileMediaData(
      //     result!.file.path,
      //     result!.file.path.split('/').last,
      //     dataFile: result!.file.readAsBytesSync(),
      //   );
      // }
    } catch (e, stackTrace) {
      log(e.toString(), name: 'TAKE_PICTURE_EXCEPTION', stackTrace: stackTrace);
    }
    return null;
  }

  @override
  FutureOr<void> open(String pathFile) {
    // OpenFilex.open(pathFile);
  }
}
