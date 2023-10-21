// // ignore_for_file: use_build_context_synchronously, duplicate_ignore

// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart' as path;
// import 'package:vif_components/const/enum.dart';
// import 'package:vif_flutter_base/vif_flutter_base.dart';

// enum FileType { image, video }

// const videoFileExt = [FileExtension.mp4, FileExtension.mov];

// class FileHelper {
//   static Future<bool> fileIsExists(String fileName) async {
//     final baseDir = await getApplicationDocumentsDirectory();
//     final basePath = baseDir.path;
//     final file = File('$basePath/$fileName');
//     return file.exists();
//   }

//   static FileType getFileType(String fileName) {
//     FileExtension extenstion = FileExtension.tryParse(fileName);
//     if (videoFileExt.contains(extenstion)) return FileType.video;
//     return FileType.image;
//   }

//   static String getFileNameFromPath(String filePath) => path.basename(filePath);

//   static Future<void> onTapDownload({required BuildContext context, required String fileUrl}) async {
//     VIFBase.I.loadingIndicator.show(context);
//     try {
//       String saveDir = await VIFBase.I.fileHelper.getDirectoryPath("LichCongTac");
//       final checked = await checkFileExisted(fileUrl: fileUrl);
//       if (checked != null) {
//         VIFBase.I.loadingIndicator.dismiss(context);
//         VIFBase.I.fileHelper.open(checked);
//         return;
//       }
//       final result = await VIFBase.I.downloader.download(
//         categorize: "LichCongTac",
//         fileID: fileUrl,
//         fileName: path.basename(fileUrl),
//         saveDir: saveDir,
//       );

//       if (result != null) {
//         VIFBase.I.loadingIndicator.dismiss(context);
//         VIFBase.I.toast.show(context, "Tải về thành công !!!");
//         VIFBase.I.fileHelper.open(result);
//       } else {
//         VIFBase.I.loadingIndicator.dismiss(context);
//         VIFBase.I.toast.show(context, "Tải về thất bại, vui lòng thử lại sau !!!");
//       }
//     } catch (e) {
//       VIFBase.I.loadingIndicator.dismiss(context);
//       log(e.toString(), name: "DOWNLOAD_FILE_FAILED");
//       VIFBase.I.toast.show(context, "Tải về thất bại, vui lòng thử lại sau !!!");
//     }
//   }

//   static Future<String?> checkFileExisted({required String fileUrl}) async {
//     try {
//       String fullPath = await VIFBase.I.fileHelper.getPathFile(path.basename(fileUrl), "LichCongTac");
//       log(fullPath, name: "DOWNLOAD_FILE2");
//       File file = File(fullPath);
//       if (await file.exists()) {
//         return fullPath;
//       }
//       return null;
//     } catch (e) {
//       log(e.toString(), name: "CHECK_FILE_EXISTED_FAILED");
//       return null;
//     }
//   }

//   static Future<VIFFileMediaData?> uploadFile({required VIFFileMediaData file, required int userId}) async {
//     try {
//       final res = await VIFBase.I.uploader
//           .uploadFromPath(pathFile: file.pathFile, categorize: "LichCongTac", userID: userId.toString());
//       log(res.toString(), name: "UPLOAD_FILE");
//       if (res != null && res.data != null) {
//         file.pathFile = res.data!;
//         return file;
//       }
//     } catch (e) {
//       log(e.toString(), name: "UPLOAD_FILE_FAILED");
//       return null;
//     }
//     return null;
//   }

//   static Future<bool> addTepDinhKem(
//       BuildContext context,
//       Function() onLoading,
//       VIFFileMediaData? tepDinhKem,
//       int userId,
//       Function(VIFFileMediaData returnFile) onUploadSuccess,
//       Function() onFailed,
//       String functionCallLog) async {
//     if (tepDinhKem == null) {
//       return false;
//     }
//     onLoading();
//     try {
//       final uploadedFile = await FileHelper.uploadFile(file: tepDinhKem, userId: userId);
//       if (uploadedFile != null) {
//         onUploadSuccess(uploadedFile);
//         return true;
//       }
//     } catch (e) {
//       VIFBase.I.toast
//           .show(context, "Không thể thêm tệp đính kèm, vui lòng thử lại sau !", categories: VIFToastCategories.error);
//       log(e.toString(), name: "$functionCallLog.addTepDinhKem");
//       onFailed();
//       return false;
//     }
//     // ignore: use_build_context_synchronously
//     VIFBase.I.toast
//         .show(context, "Không thể thêm tệp đính kèm, vui lòng thử lại sau !", categories: VIFToastCategories.error);
//     onFailed();
//     return false;
//   }
// }
