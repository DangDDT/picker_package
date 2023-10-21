import '../../exceptions/exceptions.dart';
import '../base/base_error_response_mapper.dart';

class JsonObjectErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapData(Map<String, dynamic>? entity) {
    return ServerError(
      generalServerStatusCode: entity?['statusCode'],
      generalMessage: entity?['message'],
    );
  }
}
