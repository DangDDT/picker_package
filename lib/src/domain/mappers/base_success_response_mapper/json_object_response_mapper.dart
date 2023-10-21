import '../../../../core/typedefs/typedef.dart';
import '../base/base_success_response_mapper.dart';

class JsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, T> {
  @override
  T map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic> ? decoder(response) : response;
  }
}
