import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFUploader extends VIFUploaderDataSource {
  @override
  Iterable<String> get categorizes => ['PHANANH', 'USER', 'LichCongTac'];

  String get uploadFileApi => 'https://api-demo.vietinfo.tech/SoYte/ServiceAPI/FileManager/UploadFileAlfresco';

  String get deleteFileApi =>
      'https://api-demo.vietinfo.tech/SoYte/ServiceAPI/FileManager/DeleteFileFromAlfrescoServer';

  Dio dio = Dio()..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  @override
  Future<VIFFileUploaderResult?> requestUpload(
    File file,
    String categorize,
    String userID,
  ) async {
    try {
      Response<dynamic> response;
      final fileName = path.basename(file.path);
      // if (categorize == 'USER' || categorize == 'PHANANH') {
      // final formData = FormData.fromMap({
      //   'File': await MultipartFile.fromFile(file.path, filename: fileName)
      // });
      // response = await _apiClient.baseDioClient.post(
      //   '${_coreUri.phanAnhUrl}/upload-file',
      //   data: formData,
      // );
      // } else {
      final formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(file.path, filename: fileName),
        'LoaiFileAlfresco': categorize,
      });
      response = await dio.post(
        uploadFileApi,
        data: formData,
      );
      // }

      if (response.statusCode == 200) {
        //File path which save on services.
        return VIFFileUploaderResult(
          statusCode: response.statusCode!,
          data: response.data as String?,
        );
      } else {
        return VIFFileUploaderResult(
          statusCode: -1,
          messageError: 'Lỗi không xác định',
        );
      }
    } catch (e, stackTrace) {
      log(e.toString(), name: 'UPLOAD_FILES_EXCEPTION', stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Future<bool?> requestDelete(
    String fileId,
    String categorize,
  ) async {
    try {
      final response = await dio.delete(
        deleteFileApi,
        queryParameters: {
          'fileId': fileId,
        },
      );
      if (response.statusCode == 200) {
        //File path which save on services.
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString(), name: 'DELETE_FILES_EXCEPTION');
    }
    return null;
  }
}
