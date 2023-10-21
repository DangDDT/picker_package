import '../base/app_exception.dart';

class ValidationException extends AppException {
  ValidationException(
    this.kind, {
    this.message = "Lỗi chuẩn hoá dữ liệu đầu vào",
    this.advice = "Vui lòng kiểm tra lại",
  }) : super(AppExceptionType.validation);

  final ValidationExceptionKind kind;
  final String message;
  final String advice;

  @override
  String toString() {
    return '''ValidationExceptionKind: {
      kind: $kind,
      message: $message,
      advice: $advice,
}''';
  }
}

enum ValidationExceptionKind { invalidInput, invalidOutput }
