import '../../src/domain/mappers/base/base_error_response_mapper.dart';
import '../../src/domain/mappers/base/base_success_response_mapper.dart';

class ResponseMapperConstants {
  const ResponseMapperConstants._();
  static const defaultErrorResponseMapperType = ErrorResponseMapperType.jsonObject;
  static const defaultSuccessResponseMapperType = SuccessResponseMapperType.dataJsonObject;
}
