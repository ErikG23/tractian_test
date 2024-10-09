import 'package:tractian_test/core/failures/app_failure/i_app_failure.dart';

class AppException extends IAppException {
  AppException({required super.message, super.stackTrace});
}
