// ignore_for_file: depend_on_referenced_packages, override_on_non_overriding_member

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFFileHelper extends VIFFileHelperDataSource {
  @override
  Iterable<String> get categorizes => ['App', 'CongViec'];

  @override
  FutureOr<Iterable<VIFFileMediaData>?> chooseFiles() async {
    try {
      // final pickFileResult = await FilePicker.platform.pickFiles();
      // if (pickFileResult != null && pickFileResult.files.isNotEmpty) {
      //   return pickFileResult.files.map<VIFFileMediaData>(
      //     (file) => VIFFileMediaData(
      //       file.path ?? '',
      //       file.name,
      //       dataFile: file.bytes,
      //     ),
      //   );
      // }
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace, name: 'VIF_FILE_HELPER');
    }
    return null;
  }

  @override
  FutureOr<VIFFileMediaData?> chooseFile() async {
    try {
      // final pickFileResult = await FilePicker.platform.pickFiles();
      // if (pickFileResult != null && pickFileResult.files.isNotEmpty) {
      //   final file = pickFileResult.files.first;
      //   return VIFFileMediaData(
      //     file.path ?? '',
      //     file.name,
      //     dataFile: file.bytes,
      //   );
      // }
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace, name: 'VIF_FILE_HELPER');
    }
    return null;
  }

  @override
  FutureOr<void> open(String pathFile) {
    // OpenFilex.open(pathFile);
  }

  @override
  Future<String> getDirectoryPath(
    String categorize, {
    String? userID,
    bool isCache = true,
  }) async {
    // const cacheDirectoryName = 'Cache';
    // final parentDirectoryPath = await getApplicationDocumentsDirectory();
    // if (isCache == true) {
    //   final path = '${parentDirectoryPath.path}/$cacheDirectoryName';
    //   await tryToCreateCacheDirectory(path);
    //   return path;
    // } else {
    //   return parentDirectoryPath.path;
    // }
    return '';
  }

  @override
  Future<String> getPathFile(
    String fileName,
    String categorize, {
    String? userID,
    bool isCache = true,
  }) async {
    // const cacheDirectoryName = 'Cache';
    // final parentDirectoryPath = await getApplicationDocumentsDirectory();
    // if (isCache == true) {
    //   final path = '${parentDirectoryPath.path}/$cacheDirectoryName';
    //   await tryToCreateCacheDirectory(path);
    //   return '$path/$fileName';
    // } else {
    //   final path = parentDirectoryPath.path;

    //   return '$path/$fileName';
    // }
    return '';
  }

  Future<void> tryToCreateCacheDirectory(String baseUrl) async {
    final dir = Directory(baseUrl);
    final isExist = await dir.exists();
    if (isExist) {
      return;
    } else {
      await dir.create();
    }
  }

  @override
  String getUrlFileNetwork(String pathFile, String categorize) {
    throw UnimplementedError();
  }

  @override
  String getFileUrlByCategory(String pathFile, String categorize) {
    throw UnimplementedError();
  }
}
