import '../../base/app_exception.dart';

abstract class CustomException<I> extends AppException {
  const CustomException(
    this.rootException,
  ) : super(AppExceptionType.custom);

  final Object? rootException;
}
