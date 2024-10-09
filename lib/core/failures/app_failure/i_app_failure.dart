abstract class IAppException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  const IAppException({
    required this.message,
    this.stackTrace,
  });
}
