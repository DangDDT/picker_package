import '../../exceptions/exceptions.dart';
import '../base_error_response_mapper/json_object_error_response_mapper.dart';
import 'base_data_mapper.dart';

abstract class BaseErrorResponseMapper<T> extends BaseDataMapperProfile<T, ServerError> {
  const BaseErrorResponseMapper();

  factory BaseErrorResponseMapper.fromType(ErrorResponseMapperType type) {
    switch (type) {
      case ErrorResponseMapperType.jsonObject:
        return JsonObjectErrorResponseMapper() as BaseErrorResponseMapper<T>;
    }
  }
}

enum ErrorResponseMapperType {
  jsonObject,
}
