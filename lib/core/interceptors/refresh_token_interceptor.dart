import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_instance;

import '../core_picker.dart';

class RefreshTokenInterceptor implements QueuedInterceptor {
  final _config = get_instance.Get.find(tag: CorePicker.packageName);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_config.authConfig?.accessToken != null) {
      options.headers['Authorization'] =
          'Bearer ${_config.authConfig?.accessToken}';
      options.headers['Accept'] = '*/*';
      return handler.next(options);
    } else {
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      handler.next(response);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      if (err.response!.statusCode == 401) {
        try {
          final newToken =
              await _config.authConfig?.onRefreshTokenCallback.call();
          if (newToken == null) return handler.next(err);
          final opts = Options(method: err.requestOptions.method);
          final dioClient = Dio();
          dioClient.options.headers['Authorization'] = 'Bearer $newToken';
          dioClient.options.headers['Accept'] = '*/*';
          final response = await dioClient.request<dynamic>(
            err.requestOptions.path,
            options: opts,
            cancelToken: err.requestOptions.cancelToken,
            onReceiveProgress: err.requestOptions.onReceiveProgress,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
  }
}
