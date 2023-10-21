import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFDownloader extends VIFDownloaderDataSource {
  @override
  Iterable<String> get categorizes => ['PHANANH', 'VANBAN', 'HOSO', 'LICHCONGTAC'];
  Dio dio = Dio()..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  @override
  Future<Uint8List?> requestDownload(
    String? fileID,
    String? categorize,
  ) async {
    try {
      final response = await dio.post(
        urlDownload,
        data: {
          'fileUrl': fileID,
          'LoaiFile': categorize,
        },
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      if (response.data != null) {
        return response.data as Uint8List?;
      }
    } catch (e, stackTrace) {
      log(e.toString(), name: 'DOWNLOAD_FILE', stackTrace: stackTrace);
      return null;
    }
    return null;
  }

  String get urlDownload => 'https://api-demo.vietinfo.tech/SoYte/ServiceAPI/FileManager/DownloadFileAlfresco';
}
