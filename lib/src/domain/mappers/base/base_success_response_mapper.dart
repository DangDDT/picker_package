import '../../../../core/typedefs/typedef.dart';
import '../base_success_response_mapper/data_json_array_response_mapper.dart';
import '../base_success_response_mapper/data_json_object_response_mapper.dart';
import '../base_success_response_mapper/json_array_response_mapper.dart';
import '../base_success_response_mapper/json_object_response_mapper.dart';
import '../base_success_response_mapper/result_json_array_response_mapper.dart';
import '../base_success_response_mapper/result_json_object_response_mapper.dart';

abstract class BaseSuccessResponseMapper<I, O> {
  const BaseSuccessResponseMapper();

  factory BaseSuccessResponseMapper.fromType(SuccessResponseMapperType type) {
    switch (type) {
      case SuccessResponseMapperType.dataJsonObject:
        return DataJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.dataJsonArray:
        return DataJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.jsonObject:
        return JsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.jsonArray:
        return JsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.resultJsonObject:
        return ResultJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.resultJsonArray:
        return ResultJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
    }
  }

  // ignore: avoid-dynamic
  O map(dynamic response, Decoder<I>? decoder);

  // ignore: avoid-dynamic
}

enum SuccessResponseMapperType {
  dataJsonObject,
  dataJsonArray,
  resultJsonObject,
  resultJsonArray,
  jsonObject,
  jsonArray,
}
