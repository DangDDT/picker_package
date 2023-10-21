enum AppExceptionType {
  remote,
  parse,
  remoteConfig,
  uncaught,
  validation,
  custom,
}

abstract class AppException implements Exception {
  const AppException(this.appExceptionType);

  final AppExceptionType appExceptionType;
}
