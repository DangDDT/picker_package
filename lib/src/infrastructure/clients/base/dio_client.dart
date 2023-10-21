// import 'package:dio/dio.dart' as dio_package;
// import 'package:get/get.dart' as get_package;

// import '../../../../core/core.dart';
// import '../../../domain/domain.dart';

// class DioClient {
//   static final CorePicker _config = get_package.Get.find<ModuleConfig>(tag: CorePicker.packageName);
//   static final tag = "${CorePicker.packageName.toUpperCase()}|DIO_CLIENT";

//   ///Truyền api key nếu có
//   String? apiKey;

//   final dio_package.Dio _dio;
//   dio_package.Dio get dio => _dio;

//   final SuccessResponseMapperType successResponseMapperType;
//   final ErrorResponseMapperType errorResponseMapperType;
//   final String baseUrl;
//   DioClient({
//     this.baseUrl = DefaultValueMapperConstants.defaultStringValue,
//     this.errorResponseMapperType = ResponseMapperConstants.defaultErrorResponseMapperType,
//     this.successResponseMapperType = ResponseMapperConstants.defaultSuccessResponseMapperType,
//     this.apiKey,
//   }) : _dio = dio_package.Dio(
//           dio_package.BaseOptions(
//             baseUrl: baseUrl,
//             connectTimeout: ServerTimeoutConstants.connectTimeout,
//             sendTimeout: ServerTimeoutConstants.sendTimeout,
//             receiveTimeout: ServerTimeoutConstants.receiveTimeout,
//             headers: apiKey != null ? {'apiKey': apiKey} : null,
//           ),
//         )..interceptors.addAll(
//             [
//               // if (kDebugMode && _config.additionalDataConfig.isUseLogger == true) TalkerDioLoggerInterceptor(),
//               // if (_config.authConfig != null) RefreshTokenInterceptor(),
//             ],
//           );

//   static Future<T> request<T, D>(
//     Function() request, {
//     // ignore: avoid-dynamic
//     Decoder<D>? decoder,
//     SuccessResponseMapperType? successResponseMapperType,
//     ErrorResponseMapperType? errorResponseMapperType,
//     BaseErrorResponseMapper? errorResponseMapper,
//     DataFilterMapperType? dataFilterType,
//   }) async {
//     try {
//       final response = await request.call();
//       var result = BaseSuccessResponseMapper<D, T>.fromType(
//         successResponseMapperType ?? ResponseMapperConstants.defaultSuccessResponseMapperType,
//       ).map(response, decoder);
//       if (dataFilterType != null) {
//         result = DataFilterMapper<T>.fromType(dataFilterType).filterData(result);
//       }
//       return result;
//     } on CustomException {
//       rethrow;
//     } catch (error) {
//       throw DioExceptionMapper(
//         errorResponseMapper ??
//             BaseErrorResponseMapper.fromType(
//               errorResponseMapperType ?? ResponseMapperConstants.defaultErrorResponseMapperType,
//             ),
//       ).map(error);
//     }
//   }
// }
