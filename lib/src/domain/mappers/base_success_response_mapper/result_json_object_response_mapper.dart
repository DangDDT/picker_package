import '../../../../core/typedefs/typedef.dart';
import '../../models/base/result_response.dart';
import '../base/base_success_response_mapper.dart';

class ResultJsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, ResultResponse<T>> {
  @override
  // ignore: avoid-dynamic
  ResultResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? ResultResponse.fromJson(response, (json) => decoder(json))
        : ResultResponse<T>(result: response);
  }
}
