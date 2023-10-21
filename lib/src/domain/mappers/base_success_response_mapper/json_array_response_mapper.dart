import '../../../../core/typedefs/typedef.dart';
import '../base/base_success_response_mapper.dart';

class JsonArrayResponseMapper<T> extends BaseSuccessResponseMapper<T, List<T>> {
  @override
  // ignore: avoid-dynamic
  List<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is List
        ? response.map((jsonObject) => decoder(jsonObject)).toList(growable: false)
        : [response];
  }
}
