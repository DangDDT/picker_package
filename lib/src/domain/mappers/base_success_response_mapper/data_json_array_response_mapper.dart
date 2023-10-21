import '../../../../core/typedefs/typedef.dart';
import '../../models/base/data_response.dart';
import '../base/base_success_response_mapper.dart';

class DataJsonArrayResponseMapper<T> extends BaseSuccessResponseMapper<T, DataListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  DataListResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? DataListResponse.fromJson(response, (json) => decoder(json))
        : DataListResponse<T>(data: response);
  }
}
