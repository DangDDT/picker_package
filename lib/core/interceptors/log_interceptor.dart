import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class TalkerDioLoggerInterceptor extends TalkerDioLogger {
  static final _talker = Talker();
  static const _settings = TalkerDioLoggerSettings(
    printRequestHeaders: true,
    printResponseHeaders: true,
  );
  TalkerDioLoggerInterceptor() : super(talker: _talker, settings: _settings);
}
