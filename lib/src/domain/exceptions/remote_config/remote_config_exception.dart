import '../exceptions.dart';

class RemoteConfigException extends AppException {
  final String message;

  RemoteConfigException({
    required this.kind,
    this.rootException,
    this.message = '',
  }) : super(AppExceptionType.remoteConfig);

  final RemoteConfigExceptionKind kind;
  final Object? rootException;
}

enum RemoteConfigExceptionKind { platform, unknown, unSupportPlatform }
