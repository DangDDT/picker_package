class ServerTimeoutConstants {
  const ServerTimeoutConstants._();
  static const connectTimeoutInMs = 30000;
  static const receiveTimeoutInMs = 30000;
  static const sendTimeoutInMs = 30000;

  static const connectTimeout = Duration(milliseconds: connectTimeoutInMs);
  static const receiveTimeout = Duration(milliseconds: receiveTimeoutInMs);
  static const sendTimeout = Duration(milliseconds: sendTimeoutInMs);
}
